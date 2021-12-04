defmodule Day2 do
    def main do
      case File.read("./day_2/input.txt") do
        {:ok, contents} ->
          contents
          |> String.split("\n", trim: true )
          |> driveSubmarine(0, 0, 0)
        {:error, :enoent} ->
          IO.puts("Not able to open the file.")
      end
    end

    def driveSubmarine(commands, depth, position, aim) do

      case commands do
        [] -> depth * position
        [command | tail] ->
          [dir , val | _] = command |> String.split(" ")
          val = String.to_integer(val)
          case dir do
            "forward" -> driveSubmarine(tail, depth + (aim * val), position + val, aim)
            "up" -> driveSubmarine(tail, depth, position, aim - val)
            "down" -> driveSubmarine(tail, depth, position, aim + val)
          end
      end
    end
end
