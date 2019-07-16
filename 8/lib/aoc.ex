defmodule Aoc do
  def part_one(input) do
    metadata = parse(?A, String.split(input) |> Enum.map(&String.to_integer/1), [])
    metadata |> IO.inspect |> Enum.sum
  end

# 2 3 0 3 10 11 12 1 1 0 1 99 2 1 1 2
# A----------------------------------
#     B----------- C-----------
#                      D-----

  def parse(_id, [], metadata) do
    metadata
  end

  def parse(id, [0, _metadata_count | my_metadata], metadata) do
    my_metadata |> IO.inspect
  end

  def parse(id, [child_count, metadata_count | data], metadata) do
    parse(id, [child_count - 1, metadata_count | data], metadata) ++ metadata
  end
end
