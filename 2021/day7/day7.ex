defmodule Day7 do

  def main do
    p0 = readInput("./day7/input.txt")

    p0
    |> allFuelPossibilities()
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

  def allFuelPossibilities(xs) do
    {min, max} = xs
    |> Enum.reduce([], fn({k,_}, acc) ->
      acc ++ [k]
    end)
    |> Enum.min_max()

    Enum.reduce(min..max,[], fn (x,acc) ->
      acc ++ [fuelConsuption(xs,x)]
    end)
    |> Enum.min()
  end

  def fuelConsuption(xs, d) do
    xs
    |> Enum.reduce([], fn ({k, v}, acc) ->
      acc ++ [gaussianSum(d,k) * v]
    end)
    |> Enum.sum()
  end

  # Helper function
  def gaussianSum(x0,xf) do
    {min, max} = Enum.min_max([x0,xf])
    div((max + 1 - min) * abs(max  - min), 2)
  end
end
