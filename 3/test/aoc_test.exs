defmodule AocTest do
  use ExUnit.Case
  doctest Aoc

  @input Aoc.read_input(File.read!("input"))
  @part_one_test_input Aoc.read_input("""
#1 @ 1,3: 4x4
#2 @ 3,1: 4x4
#3 @ 5,5: 2x2
""")

  def print(map) do
    for y <- Range.new(0, 7) do
      for x <- Range.new(0, 7) do
        l = Map.get(map, {x, y}, [])
        IO.write(
          case length(l) do
            0 -> "."
            1 -> hd(l)
            _ -> "X"
          end
        )
      end
      IO.puts("")
    end
  end

  test "part_one_test_input" do
    assert 4 == Aoc.part_one(@part_one_test_input)
  end

  test "part_one" do
    assert 119551 == Aoc.part_one(@input)
  end

  test "part_two" do
    assert :mu == Aoc.part_two(@input)
  end

end
