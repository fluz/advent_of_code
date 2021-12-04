defmodule Day3 do
    def main do
      case File.read("./day_3/input.txt") do
        {:ok, contents} ->
          input = contents
          |> String.split("\n", trim: true )
          |> Enum.map(&String.graphemes/1)
          |> transpose()

          calcO2(input,0) * calcCO2(input,0)
          # |> calcGammaEpsilon("","")
        {:error, :enoent} ->
          IO.puts("Not able to open the file.")
      end
    end

    def transpose(xs) do
      xs |> Enum.zip() |> Enum.map(&Tuple.to_list/1)
    end

    def calcO2(xs, counter) do
      if counter < length(xs)  do
        x = Enum.at(xs, counter)
        ones = (x |> Enum.map(&String.to_integer/1) |> Enum.sum())
        rating = if (ones >= (length(x) - ones)) do "1" else "0" end
        new_xs = xs |> transpose() |> Enum.filter(fn y -> Enum.at(y,counter) == rating end) |> transpose()
        calcO2(new_xs, counter+1)
      else
        xs |> transpose() |> Enum.join() |> Integer.parse(2) |> elem(0)
      end
    end

    def calcCO2(xs, counter) do
      if counter < length(xs) and length(xs|> transpose()) > 1 do
        x = Enum.at(xs, counter)
        ones = (x |> Enum.map(&String.to_integer/1) |> Enum.sum())
        rating = if (ones < (length(x) - ones)) do "1" else "0" end
        new_xs = xs |> transpose() |> Enum.filter(fn y -> Enum.at(y,counter) == rating end) |> transpose()
        calcCO2(new_xs, counter+1)
      else
        xs |> transpose() |> Enum.join() |> Integer.parse(2) |> elem(0)
      end
    end

    def calcGammaEpsilon(diagnostics, gamma, epsilon) do
      case diagnostics do
        [] ->
          g = Integer.parse(gamma,2) |> elem(0)
          e = Integer.parse(epsilon,2) |> elem(0)
          e * g
        [x|tail] ->
          bit = x |> Enum.map(&String.to_integer/1) |> Enum.sum()
          if bit > div(length(x),2) do
            calcGammaEpsilon(tail,gamma<>"1", epsilon<>"0")
          else
            calcGammaEpsilon(tail,gamma<>"0", epsilon<>"1")
          end
      end
    end
end
