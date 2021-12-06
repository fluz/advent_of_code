defmodule Day1 do

  def main do
    case File.read("input.txt") do
      {:ok, contents} ->
        contents
        |> String.split("\n", trim: true )
        |> Enum.map(&String.to_integer/1)
        |> sumAvg([])
        |> countPrevIncr(0)
      {:error, :enoent} ->
        IO.puts("Not able to open the file.")
    end
  end

  def sumAvg(ns, acc) do
    case ns do
    [prev, curr, next | tail] -> sumAvg([curr, next | tail],  [(prev + curr + next) | acc])
    _ -> Enum.reverse(acc)
    end
  end

  def countPrevIncr(ns, count) do
    case ns do
      [prev, curr | tail] -> countPrevIncr([curr | tail], count + (if prev < curr do 1 else 0 end))
      _ -> IO.puts(count)
    end
  end
end
