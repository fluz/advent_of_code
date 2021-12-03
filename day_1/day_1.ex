defmodule Day1 do
    def main do
      {:ok, contents} = File.read("input.txt")
      cs = contents |> String.split("\n", trim: true )|> Enum.map(&String.to_integer/1)
      countPrevIncrease(cs, 0)
    end

    def countPrevIncrease(numbers, count) do
      case numbers do
        [prev, curr | tail] ->
          countPrevIncrease([curr | tail], count + (if prev < curr do 1 else 0 end))
        _ -> IO.puts(count)
      end
    end

end
