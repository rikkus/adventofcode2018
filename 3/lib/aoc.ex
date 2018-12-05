defmodule Aoc do

  def read_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      String.split(line, ~r/[^\d]+/, trim: true)
      |> Enum.map(&String.to_integer/1)
    end)
  end

  def to_map(input) do
    input
    |> Enum.map(fn line ->
      [id, x, y, w, h] = line
      for i <- Range.new(x, x + w - 1), j <- Range.new(y, y + h - 1), do: {id, i, j}
    end)
    |> List.flatten
    |> Enum.reduce(%{}, fn {id, i, j}, map -> Map.update(map, {i, j}, [id], fn l -> [id | l] end) end)
  end


  def part_one(input) do
    input
    |> to_map
    |> Map.values
    |> Enum.count(fn cell -> length(cell) > 1 end)
  end

  def part_two(input) do

    ids = input |> Enum.map(fn line -> hd(line) end) |> MapSet.new()

    overlapping = input
    |> to_map
    |> Map.values
    |> Enum.filter(fn l -> length(l) > 1 end)
    |> List.flatten
    |> Enum.reduce(MapSet.new(), fn id, set -> MapSet.put(set, id) end)

    MapSet.difference(ids, overlapping) |> Enum.to_list() |> hd

  end

end
