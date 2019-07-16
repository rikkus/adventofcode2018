defmodule Aoc.Print do
  alias Aoc.Game
  @spec print(Game.marble_value(), Game.marble_value()) :: :ok
  def print(node, current) do
    if node == current do
      IO.write(String.pad_leading("(" <> Integer.to_string(node), 3))
      IO.write(")")
    else
      IO.write(String.pad_leading(Integer.to_string(node), 3))
      IO.write(" ")
    end
  end

  @spec print(any, non_neg_integer, %{next: non_neg_integer}, non_neg_integer) :: :ok
  def print(_marbles, node, %{next: 0}, current) do
    print(node, current)
    IO.puts("")
  end

  def print(marbles, node, %{next: next, previous: _previous}, current) do
    print(node, current)
    print(marbles, next, Map.get(marbles, next), current)
  end

  @spec print_state(Game.t()) :: Game.t
  def print_state(game = %Game{player_index: player_index, marbles: marbles, current_marble: current}) do
    player_index = case player_index do
      nil -> "-"
      n -> Integer.to_string(n)
    end
    IO.write("[#{player_index}]")
    print(marbles, 0, Map.get(marbles, 0), current)
    game
  end
end
