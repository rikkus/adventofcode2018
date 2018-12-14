defmodule AocTest do
  use ExUnit.Case
  doctest Aoc

  @test_input "dabAcCaCBAcCcaDA"
  @test_expected 10
  @input File.read!("input") |> String.trim()

  test "part one test input simple reduce",
    do: assert(@test_expected == Aoc.react(@test_input))

  test "part one test input reduce and pattern match",
    do: assert(@test_expected == Aoc.react2(@test_input))

  test "part one test input binary pattern match and manual recursion",
    do: assert(@test_expected == Aoc.react3(@test_input))

  test "part_one",
    do: assert(9154 == Aoc.react3(@input))

  test "part_two test input",
    do: assert(4 == Aoc.best_react(@test_input))

  test "part_two",
    do: assert(4556 == Aoc.best_react(@input))
end
