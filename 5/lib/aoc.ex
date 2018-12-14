defmodule Aoc do

  def best_react(polymer) do
    ?A..?Z
    |> Enum.map(fn c ->

      upper = List.to_string([c])
      lower = String.downcase(upper)

      polymer
      |> String.replace([upper, lower], "")
      |> Aoc.react()

    end)
    |> Enum.min
  end

  def react3(polymer) when is_binary(polymer),
    do: react3(polymer, [])

  def react3(<<c1, text::binary>>, [c2 | acc]) when abs(c1 - c2) == 32,
    do: react3(text, acc)

  def react3(<<c, text::binary>>, acc),
    do: react3(text, [c | acc])

  def react3(<<>>, acc),
    do: acc |> length()

  def react2(polymer) do
    polymer
    |> String.to_charlist()
    |> Enum.reduce([], fn c, acc ->
      case acc do
        [x | _xs] when abs(c - x) == 32 -> tl(acc)
        _ -> [c | acc]
      end
    end)
    |> length()
  end

  def react(polymer) do
    polymer
    |> String.to_charlist()
    |> Enum.reduce([], fn c, acc ->
      if !Enum.empty?(acc) and abs(Enum.at(acc, 0) - c) == 32 do
        tl(acc)
      else
        [c | acc]
      end
    end)
    |> length()
  end
end
