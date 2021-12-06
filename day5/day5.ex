defmodule Day5 do

  def main do
    points = readInput("./day5/input.txt")

    diagram = %{}

    diagram = points
    |> addVerLines(diagram)

    diagram = points
    |> addHorLines(diagram)

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
end
