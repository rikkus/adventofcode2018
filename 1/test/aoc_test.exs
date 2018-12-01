defmodule AocTest do
  use ExUnit.Case
  doctest Aoc

  @input File.read!("input")
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)
    
  test "1-1", do: assert Aoc.part_one([+1, -2, +3, +1]) == 3
  test "1-2", do: assert Aoc.part_one([+1, +1, +1]) == 3
  test "1-3", do: assert Aoc.part_one([+1, +1, -2]) == 0
  test "1-4", do: assert Aoc.part_one([-1, -2, -3]) == -6
  test "1-!", do: assert Aoc.part_one(@input) == 454

  test "2-1", do: assert Aoc.part_two([+1, -1]) == 0
  test "2-2", do: assert Aoc.part_two([+3, +3, +4, -2, -4]) == 10
  test "2-3", do: assert Aoc.part_two([-6, +3, +8, +5, -6]) == 5
  test "2-4", do: assert Aoc.part_two([+7, +7, -2, -7, -4]) == 14
  test "2-!", do: assert Aoc.part_two(@input) == 566
end
