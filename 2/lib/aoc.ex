defmodule Aoc do

  @spec min([any()]) :: any()
  def min(a) do
    Enum.reduce(a, fn item, acc -> if item < acc do item else acc end end)
  end

  @spec ld([char()], [char()], map()) :: {non_neg_integer(), map()}
  def ld([], t, cache), do: {length(t), Map.put(cache, {[], t}, length(t))}
  def ld(s, [], cache), do: {length(s), Map.put(cache, {[], s}, length(s))}
  def ld([x|s], [x|t], cache), do: ld(s, t, cache)
  def ld([_sh|st]=s, [_th|tt]=t, cache) do
    if Map.has_key?(cache, {s, t}) do
      {Map.get(cache, {s, t}), cache}
    else
      {l1, c1} = ld(s, tt, cache)
      {l2, c2} = ld(st, t, c1)
      {l3, c3} = ld(st, tt, c2)
      l = 1 + Aoc.min([l1, l2, l3])
      {l, Map.put(c3, {s, t}, l)}
    end
  end

  @spec ld(binary(), binary()) :: non_neg_integer()
  def ld(s, t) do
    ld(String.graphemes(s), String.graphemes(t), Map.new()) |> elem(0)
  end

  @spec part_two([binary()]) :: binary
  def part_two(input) do
    input |> Enum.reduce_while(
      MapSet.new(),
      fn line, set ->
        match = Enum.find(set, nil, fn previous -> ld(line, previous) == 1 end)
        case match do
          nil -> {:cont, MapSet.put(set, line)}
          _   -> {:halt, {line, match}}
        end
      end
    )
  end

  @spec letter_frequencies(binary()) :: any()
  def letter_frequencies(input) do
    Enum.reduce(
      String.graphemes(input),
      %{},
      fn letter, map ->
        Map.update(map, letter, 1, &(&1 + 1))
      end
    )
  end

  @spec count_equal([any()], any()) :: non_neg_integer()
  def count_equal(enum, value), do: Enum.count(enum, fn v -> v == value end)

  @spec pairs_and_triples(binary()) :: {non_neg_integer(), non_neg_integer()}
  def pairs_and_triples(input) do
      values = input |> Aoc.letter_frequencies |> Map.values
      {count_equal(values, 2), count_equal(values, 3)}
  end

  @spec part_one([binary()]) :: number()
  def part_one(input) do
    {p, t} = input |> Enum.reduce({0, 0}, fn line, {pairs, triples} ->
      {line_pairs, line_triples} = pairs_and_triples(line)
      {pairs + min(1, line_pairs), triples + min(1, line_triples)}
    end)
    p * t
  end

end
