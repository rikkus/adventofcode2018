defmodule Aoc do
  alias Aoc.Game
  import Aoc.Print

  @spec part_one(Game.player_count(), Game.rounds_count()) :: Game.score()
  def part_one(player_count, rounds) do
    IO.puts("Welcome to the game! #{player_count} players will play #{rounds} rounds.")
    game = Game.new(player_count, rounds)
    Game.play(game, &Aoc.Print.print_state/1)
  end
end
