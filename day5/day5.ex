defmodule Day5 do

  def main do
    points = readInput("./day5/input_test.txt")
  end

  def readInput(filename) do
    case File.read(filename) do
      {:ok, contents} ->
        contents
        |> String.split("\n", trim: true)
        |> Enum.map(fn z -> Regex.split(~r/ -> |,/,z) end)
        |> Enum.map(fn pos ->
          %{"x1" => String.to_integer(Enum.at(pos,0)),
            "y1" => String.to_integer(Enum.at(pos,1)),
            "x2" => String.to_integer(Enum.at(pos,2)),
            "y2" => String.to_integer(Enum.at(pos,3))}
          end)
      {:error, :enoent} ->
        IO.puts("Not able to open the file.")
    end

  end


end
