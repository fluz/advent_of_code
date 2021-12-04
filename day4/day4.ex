defmodule Day4 do

  def main do
    {draw, boards} = readInput("./day4/input_test.txt")

  end

  def readInput(filename) do
    case File.read(filename) do
      {:ok, contents} ->
        [rawDraw | rawBoards] = contents
        |> String.split("\n\n", trim: true)

        draw = rawDraw
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

        {draw, boards}
      {:error, :enoent} ->
        IO.puts("Not able to open the file.")
    end

  end
end
