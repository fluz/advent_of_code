defmodule Day8 do

  def main do
    p0 = readInput("./day8/input_test.txt")

    p0
    # Regex.split(~r/ /,uniq_signal_pattern, trim: true)
    # |> Enum.reduce(%{}, fn (y, acc) ->
    #   Map.put(acc, sortKeysDigits(y), 0)
    # end)
    # |> correctDigits()

  end

  def readInput(filename) do
    case File.read(filename) do
      {:ok, contents} ->

        Regex.split(~r/\n/,contents, trim: true)
        |> Enum.reduce([], fn (x,acc) ->
          [uniq_signal_pattern|[four_output_digits|_]] = Regex.split(~r/\|/, x, trim: true)

          u = Regex.split(~r/ /, uniq_signal_pattern, trim: true)
          o = Regex.split(~r/ /, four_output_digits, trim: true)
          acc ++ [{u, o}]
        end)
      {:error, :enoent} ->
        IO.puts("Not able to open the file.")
    end
  end

  # Helper functions
  def sortKeysDigits(x) do
    x
    |> String.graphemes()
    |> Enum.sort()
    |> Enum.join()
  end

  def correctDigits(xs) do
    xs
    |> Enum.reduce(%{},fn ({k,v}, acc) ->
      # IO.puts("#{k} --> #{String.length(k)}")
      case String.length(k) do
        2 -> {1, k}
        3 -> {7, k}
        4 -> {4, k}
        7 -> {8, k}
        _ -> {k, String.length(k)}
      end
    end)
  end
end
