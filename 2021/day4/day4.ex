defmodule Day4 do

  def main do
    {ds, bs} = readInput("./day4/input.txt")
    updateDraws(ds, bs, [])
  end

  def readInput(filename) do
    case File.read(filename) do
      {:ok, contents} ->
        [rawDraw | rawBoards] = contents
        |> String.split("\n\n", trim: true)

        draws = rawDraw
        |> String.split(",", trim: true)
        |> Enum.map(&String.to_integer/1)

        boards = rawBoards
        |> Enum.map(fn x -> x
          |> String.split("\n", trim: true)
          |> Enum.map(fn y -> y
            |> String.split(" ", trim: true)
            |> Enum.map(&String.to_integer/1)
            end)
          end)

        {draws, boards}
      {:error, :enoent} ->
        IO.puts("Not able to open the file.")
    end

  end

  def updateDraws(xs, ys, zs) do
    case xs do
      [] -> Enum.reverse(zs) |> Enum.at(0)
      [x | xs_] ->
        if Enum.empty?(ys) do
          Enum.reverse(zs) |> Enum.at(0)
        else
          ys = updateBoards(ys, x)
          case hasWinner(ys, [], []) do
            {[], _} -> updateDraws(xs_, ys, zs)
            {total, bs} ->
              updateDraws(xs_, bs, zs ++ Enum.map(total, fn t -> t * x end))
          end
        end
    end
  end

  def updateBoards(xs, d) do
    updateBoards(xs, [], d)
  end

  def updateBoards(xs, ys, d) do
    case xs do
      [] -> ys
      [x | xs_] -> updateBoards(xs_, ys ++ [updateBoard(x, d)], d)
    end
  end

  def updateBoard(xs, d) do
    Enum.map(xs, fn ys ->
      Enum.map(ys, fn y ->
        if y == d do -1 else y end
      end)
    end)
  end

  def hasWinner(xs, prev_xs, result) do
    case xs do
      [] -> {result, prev_xs}
      [x| xs_] ->
        if isBoardWinner(x) do
          hasWinner(xs_, prev_xs, [sumBoard(x)] ++ result)
        else
          hasWinner(xs_, prev_xs ++ [x], result)
        end
    end
  end

  def isBoardWinner(xs) do
    checkRow = sumList(xs) |> Enum.member?(-5)
    txs = transpose(xs)
    checkColumn = sumList(txs) |> Enum.member?(-5)
    (checkRow or checkColumn)
  end

  def sumBoard(xs) do
    Enum.map(xs, fn ys ->
      Enum.reduce(ys, 0, fn (w,acc) -> if w > 0 do w + acc else acc end end)
    end)
    |> Enum.sum()
  end

  # Helper functions
  def transpose(xs) do
    xs |> Enum.zip() |> Enum.map(&Tuple.to_list/1)
  end

  def sumList(xs) do
    xs |> Enum.map(fn x -> Enum.sum(x) end)
  end

end
