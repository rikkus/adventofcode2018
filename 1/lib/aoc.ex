defmodule Aoc do
  def part_one(input) do
    input |> Enum.sum
  end

  def part_two(input) do
    input
    |> Stream.cycle
    |> Enum.reduce_while(
      {0, MapSet.new([0])},
      fn change, {frequency, seen} ->
        new_frequency = frequency + change
        if MapSet.member?(seen, new_frequency) do
          {:halt, new_frequency}
        else
          {:cont, {new_frequency, MapSet.put(seen, new_frequency)}}
        end
      end
    )
  end
end
