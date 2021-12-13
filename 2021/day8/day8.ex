defmodule Day8 do

  def main do
    input = readInput("./day8/input.txt")

    input
    |> Enum.map(fn {signal, out} ->
      table = signal
      |> sortKeysDigits()
      |> findOneFourSevenEightDigits()
      |> findThreeDigit()
      |> findSixDigit()
      |> findFiveDigit()
      |> findTwoDigit()
      |> findNineDigit()
      |> findZeroDigit()
      |> Map.new(fn {k,v} -> {v,k} end)

      out
      |> sortKeysDigits()
      |> Enum.map(fn x -> table[x] end)
      |> Enum.map_join(&(&1 * 1))
      |> String.to_integer()
      # |> Enum.unzip()
      # |> Enum.map(&String.to_integer/1)
      # |> Enum.filter(fn x -> x == 1 or x == 7 or x == 8 or x == 4 end)
      # |> Enum.count()
      # |> Enum.sum()
    end)

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
  def sortKeysDigits(xs) do
    xs
    |> Enum.map(fn x ->
      x
      |> String.graphemes()
      |> Enum.sort()
      |> Enum.join()
    end)
  end

  def findOneFourSevenEightDigits(xs) do
    xs
    |> Enum.reduce(%{}, fn (x,acc) ->
      case String.length(x) do
        2 -> Map.put(acc,1, x)
        3 -> Map.put(acc,7, x)
        4 -> Map.put(acc,4, x)
        7 -> Map.put(acc,8, x)
        _ -> Map.put(acc,x, String.length(x))
      end
    end)
  end

  def findThreeDigit(xs) do
    one = xs[1] |> String.graphemes()
    three = xs
    |> Map.filter(fn {_,v} ->
      v == 5
    end)
    |> Map.filter(fn {k,_} ->
      three = k |> String.graphemes()
      length(three -- one) == 3
    end)
    |> Enum.map(fn {k,_} -> k end)

    Map.drop(xs, three)
    |> Map.put(3, three |> hd)
  end

  def findSixDigit(xs) do
    one = xs[1] |> String.graphemes()
    six = xs
    |> Map.filter(fn {_,v} ->
      v == 6
    end)
    |> Map.filter(fn {k,_} ->
      six = k |> String.graphemes()
      length(six -- one) == 5
    end)
    |> Enum.map(fn {k,_} -> k end)

    Map.drop(xs, six)
    |> Map.put(6, six |> hd)
  end

  def findFiveDigit(xs) do
    six = xs[6] |> String.graphemes()
    five = xs
    |> Map.filter(fn {_,v} ->
      v == 5
    end)
    |> Map.filter(fn {k,_} ->
      five = k |> String.graphemes()
      length(six -- five) == 1
    end)
    |> Enum.map(fn {k,_} -> k end)

    Map.drop(xs, five)
    |> Map.put(5, five |> hd)
  end

  def findTwoDigit(xs) do
    two = xs
    |> Map.filter(fn {_,v} ->
      v == 5
    end)
    |> Enum.map(fn {k,_} -> k end)

    Map.drop(xs, two)
    |> Map.put(2, two |> hd)
  end

  def findNineDigit(xs) do
    five = xs[5] |> String.graphemes()
    nine = xs
    |> Map.filter(fn {_,v} ->
      v == 6
    end)
    |> Map.filter(fn {k,_} ->
      nine = k |> String.graphemes()
      length(nine -- five) == 1
    end)
    |> Enum.map(fn {k,_} -> k end)

    Map.drop(xs, nine)
    |> Map.put(9, nine |> hd)
  end

  def findZeroDigit(xs) do
    zero = xs
    |> Map.filter(fn {_,v} ->
      v == 6
    end)
    |> Enum.map(fn {k,_} -> k end)

    Map.drop(xs, zero)
    |> Map.put(0, zero |> hd)
  end


  def correctDigits(xs) do
    xs
    |> Enum.reduce([],fn (x,acc) ->
      [sortKeysDigits(x)] ++ acc
    end)
    |> findOneFourSevenEightDigits()
  end
end
