defmodule Day6 do

  def main do
    p0 = readInput("./day6/input.txt")

    p0
    |> updateGeneration(256)
    |> sumPopulation()
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

  def updateGeneration(xs, d) do
    case d do
      0 -> xs
      _ ->
        newGen = %{}
        xs
        |> Enum.reduce(newGen, fn ({key,value}, acc) ->
          case key do
            0 ->
              Map.update(acc, 6, value, fn c -> c + value end)
              |> Map.update( 8, value, fn c -> c + value end)
            k -> Map.update(acc, k-1, value, fn c -> c + value end)
          end
        end)
        |> updateGeneration(d - 1)
    end
  end

  # Helper function
  def sumPopulation(xs) do
    xs
    |> Enum.reduce(0, fn({_k, v}, acc) -> v + acc end)
  end

end
