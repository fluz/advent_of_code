defmodule Day6 do

  def main do
    p0 = readInput("./day6/input_test.txt")
  end

  def readInput(filename) do
    case File.read(filename) do
      {:ok, contents} ->

        Regex.split(~r/\n|,/,contents, trim: true)
        |> Enum.map(&String.to_integer/1)
        |> Enum.reduce(%{}, fn x, acc -> Map.update(acc, x, 1, &(&1 + 1)) end)

      {:error, :enoent} ->
        IO.puts("Not able to open the file.")
    end
  end

end
