defmodule Aoc do
  def parse(input) do
    g = Graph.new()

    edges =
      input
      |> String.split("\n", trim: true)
      |> Enum.map(fn line ->
        %{"a" => a, "b" => b} =
          Regex.named_captures(
            ~r/(?<a>[A-Z]+) must be finished before step (?<b>[A-Z]+)/,
            line
          )

        {a, b}
      end)

    Graph.add_edges(g, edges)
  end

  def example() do
    parse("
Step C must be finished before step A can begin.
Step C must be finished before step F can begin.
Step A must be finished before step B can begin.
Step A must be finished before step D can begin.
Step B must be finished before step E can begin.
Step D must be finished before step E can begin.
Step F must be finished before step E can begin.
")
  end

  def start_vertex(graph) do
    [v] =
      Graph.vertices(graph)
      |> Enum.filter(fn v -> Graph.in_degree(graph, v) == 0 end)
    v
  end

  def traverse(_graph, [], _visited, acc), do: acc |> Enum.reverse

  def traverse(graph, [head | tail], visited, acc) do
    IO.inspect %{queue: [head | tail], visited: visited, found: acc |> Enum.reverse}
    if MapSet.member?(visited, head) do
      traverse(graph, tail, visited, acc)
    else
      visited = MapSet.put(visited, head)
      new_queue = (Graph.out_neighbors(graph, head) |> Enum.sort)
      traverse(graph, new_queue, visited, [head | acc])
    end
  end

  def part_one(input) do
    g = parse(input)
    traverse(g, [start_vertex(g)], MapSet.new(), [])
  end
end
