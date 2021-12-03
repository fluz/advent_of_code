defmodule Day2 do
    def main do
      case File.read("./day_2/input.txt") do
        {:ok, contents} ->
          contents
          |> String.split("\n", trim: true )
          |> driveSubmarine(0, 0)
        {:error, :enoent} ->
          IO.puts("Not able to open the file.")
      end
    end

    def driveSubmarine(commands, depth, position) do

      case commands do
        [] -> depth * position
        [command | tail] ->
          case command do
            "forward " <> l -> driveSubmarine(tail,depth, position + String.to_integer(l))
            "up " <> u -> driveSubmarine(tail, depth - String.to_integer(u), position)
            "down " <> d -> driveSubmarine(tail, depth + String.to_integer(d), position)
          end
      end
    end
end
