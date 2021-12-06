defmodule Day5 do

  def main do
    points = readInput("./day5/input.txt")

    diagram = %{}

    diagram = points
    |> addVerLines(diagram)

    diagram = points
    |> addHorLines(diagram)

    diagram = points
    |> addDiagLines(diagram)

    diagram
    |> Map.filter(fn {_,value} -> (value > 1) end)
    |> map_size()
  end

  def readInput(filename) do
    case File.read(filename) do
      {:ok, contents} ->
        contents
        |> String.split("\n", trim: true)
        |> Enum.map(fn z -> Regex.split(~r/ -> |,/,z) end)
        |> Enum.map(fn pos ->
          %{x1: String.to_integer(Enum.at(pos,0)),
            y1: String.to_integer(Enum.at(pos,1)),
            x2: String.to_integer(Enum.at(pos,2)),
            y2: String.to_integer(Enum.at(pos,3))}
          end)
      {:error, :enoent} ->
        IO.puts("Not able to open the file.")
    end

  end

  def addVerLines(xs, mp) do
    xs
    |> Enum.filter(fn p -> p[:x1] == p[:x2] end)
    |> Enum.reduce(mp, fn (p, acc) ->
      {y_min, y_max} = Enum.min_max([p[:y1],p[:y2]])
      x = p[:x1]
      Enum.reduce(y_min..y_max, acc, fn (y, bcc) ->
        Map.update(bcc, "#{x},#{y}", 1, fn c -> c + 1 end)
      end)
    end)
  end

  def addHorLines(ys, mp) do
    ys
    |> Enum.filter(fn p -> p[:y1] == p[:y2] end)
    |> Enum.reduce(mp, fn (p, acc) ->
      {x_min, x_max} = Enum.min_max([p[:x1],p[:x2]])
      y = p[:y1]
      Enum.reduce(x_min..x_max, acc, fn (x, bcc) ->
        Map.update(bcc, "#{x},#{y}", 1, fn c -> c + 1 end)
      end)
    end)
  end

  def addDiagLines(ds, mp) do
    ds
    |> Enum.filter(fn p -> isDiagonal(p[:x1],p[:y1],p[:x2],p[:y2]) end)
    |> Enum.reduce(mp, fn (p, acc) ->
      {x_min, x_max} = Enum.min_max([p[:x1],p[:x2]])
      factor_x = if (p[:x1] == x_min) do 1 else -1 end
      {y_min, _} = Enum.min_max([p[:y1],p[:y2]])
      factor_y = if (p[:y1] == y_min) do 1 else -1 end
      n = x_max - x_min
      Enum.reduce(0..n, acc, fn (step, bcc) ->
        x = p[:x1] + step * factor_x
        y = p[:y1] + step * factor_y
        Map.update(bcc, "#{x},#{y}", 1, fn c -> c + 1 end)
      end)
    end)
  end

  # Helper function
  def isDiagonal(x1,y1,x2,y2) do
    {min_x, max_x} = Enum.min_max([x1,x2])
    {min_y, max_y} = Enum.min_max([y1,y2])
    (max_x - min_x == max_y - min_y)
  end

end
