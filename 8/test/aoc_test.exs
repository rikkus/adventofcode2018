defmodule AocTest do
  use ExUnit.Case
  doctest Aoc

  test "example" do
    assert Aoc.part_one("2 3 0 3 10 11 12 1 1 0 1 99 2 1 1 2") == 138
  end
end
