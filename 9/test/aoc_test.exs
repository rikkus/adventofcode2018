defmodule AocTest do
  use ExUnit.Case

  #test "insert" do
  #  marbles = %{0 => %{next: 0, previous: 0}}
  #  marbles = Aoc.Game.insert(marbles, 1, [after: 0, before: 0])
  #  marbles = Aoc.Game.insert(marbles, 2, [after: 0, before: 1])
  #end

  test "example" do
    assert Aoc.part_one(9, 25) == 32
#    #assert Aoc.part_one(9, 25) == 32
  end
end
