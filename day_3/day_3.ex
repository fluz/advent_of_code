defmodule Day3 do
    def main do
      case File.read("./day_3/input.txt") do
        {:ok, contents} ->
          contents
          |> String.split("\n", trim: true )
          |> Enum.map(&String.graphemes/1)
          |> Enum.zip()
          |> Enum.map(&Tuple.to_list/1)
          |> calcGammaEpsilon("","")
        {:error, :enoent} ->
          IO.puts("Not able to open the file.")
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
