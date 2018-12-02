defmodule AocTest do
  use ExUnit.Case
  doctest Aoc

  @input File.read!("input")
    |> String.split("\n", trim: true)

  @part_one_test_cases [
    {"abcdef", 0, 0},
    {"bababc", 1, 1},
    {"abbcde", 1, 0},
    {"abcccd", 0, 1},
    {"aabcdd", 2, 0},
    {"abcdee", 1, 0},
    {"ababab", 0, 2}
  ]

  test "letter_frequencies" do
    assert Aoc.letter_frequencies("aabccc") == %{"a" => 2, "b" => 1, "c" => 3}
  end

  test "pairs_and_triples" do
    for {input, pairs, triples} <- @part_one_test_cases do
      assert {pairs, triples} == Aoc.pairs_and_triples(input)
    end
  end

  test "1 test input" do
    assert 12 == Aoc.part_one(@part_one_test_cases |> Enum.map(fn x -> elem(x, 0) end))
  end

  test "1" do
    assert 7872 == Aoc.part_one(@input)
  end

  test "ld" do
    assert 1 == Aoc.ld("abcde", "abede")
  end

  test "ld2" do
    assert 2 == Aoc.ld("abcde", "abxxe")
  end

  test "ld3" do
    assert 0 == Aoc.ld("", "")
  end

  test "ld4" do
    assert 2 == Aoc.ld("", "ab")
  end

  test "ld5" do
    assert 1 == Aoc.ld("a", "")
  end

  test "2" do
    assert {"tjxmoewpdkyaihvrndwfluwbzc", "tjxmoewpdkyaihvrndgfluwbzc"} == Aoc.part_two(@input)
  end

end
