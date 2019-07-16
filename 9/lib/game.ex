defmodule Aoc.Game do
  alias __MODULE__

  @type score :: non_neg_integer()
  @type rounds_count() :: non_neg_integer()
  @type player_count() :: non_neg_integer()
  @type player_index() :: non_neg_integer()
  @type rotation_count() :: non_neg_integer()
  @type marble_index() :: non_neg_integer()
  @type marble_value() :: non_neg_integer()
  @type marble_node_map() :: %{}

  @initial_marbles_state %{0 => %{next: 0, previous: 0}}

  defstruct [
    :player_count,
    :player_index,
    :remaining_rounds,
    :marble_value,
    :marbles,
    :current_marble,
    :points
  ]

  @spec new(player_count(), rounds_count()) :: Game.t()
  def new(player_count, rounds) do
    %Game{
      player_count: player_count,
      player_index: nil,
      remaining_rounds: rounds,
      marble_value: 1,
      marbles: @initial_marbles_state,
      current_marble: 0,
      points: %{}
    }
  end

  @spec rotate(rotation_count(), Game.t, (Game.t() -> Game.t())) :: Game.t
  def rotate(0, game, printer) do
    IO.puts("Rotated around to the 7th marble counter-clockwise. Let's continue.")
    play(%{game | marble_value: game.marble_value + 1}, printer)
  end

  def rotate(remaining_rotations, game, printer) do
    IO.puts("rotate2")
    IO.puts(
      "Rotating around to the 7th marble counter-clockwise.
Current marble is #{game.current_marble}.
Rounds at #{game.remaining_rounds}"
    )
    prev = Map.get(game.marbles, game.current_marble).previous

    IO.puts("Previous marble is #{prev}")

    rotate(
      remaining_rotations - 1,
      %{game | current_marble: Map.get(game.marbles, game.current_marble).previous},
      printer
    )
  end

  @spec play(Game.t, (Game.t -> Game.t)) :: Game.t
  def play(%Game{remaining_rounds: 0} = game, _printer) do
    IO.puts("Last round was played")
    game
  end

  def play(game = %Game{marble_value: marble_value}, printer)
  when rem(marble_value, 24) == 0 do

    IO.puts("We hit a marble index (#{marble_value}) which is divisible by 23!")

    game = %{game | points: Map.update(game.points, game.player_index, game.marble_value, &(&1 + 1))}

    game = rotate(7, game, printer)

    current = game.current_marble
    next = Map.get(game.marbles, current).next

    game = %{game |
      points: Map.update(game.points, game.player_index, game.marble_value, &(&1 + 1)),
      marbles: delete(game.marbles, current),
      current_marble: next
    }

    printer.(game)

    game
  end

  def play(game, printer) do
    # (m?) <- current_marble -> (m1)    (current_marble) <- m1 -> (m2)                        (m1) <- m2 -> (m3)
    # (m?) <- current_marble -> (m1)    (current_marble) <- m1 -> (mX)   (m1) <- mX -> (m2)   (mX) <- m2 -> (m3)

    # current_marble  m1 m2 m3
    # m1 m2 m3
    m1 = Map.get(game.marbles, game.current_marble).next
    m2 = Map.get(game.marbles, m1).next

    marbles = insert(game.marbles, game.marble_value, after: m1, before: m2)
    printer.(game)

    new_player_index = case game.player_index do
      nil -> 1
      n -> rem(n, game.player_count) + 1
    end

    play(%{game |
      marbles: marbles,
      player_index: new_player_index,
      remaining_rounds: game.remaining_rounds - 1,
      marble_value: game.marble_value + 1,
      current_marble: game.marble_value
      },
      printer
    )
  end

  @spec insert(%{}, any, [{:after, any} | {:before, any}]) :: %{}
  def insert(marbles, marble_value, after: aft, before: before) do
    #IO.inspect(%{value: marble_value, before: before, after: aft}, label: "insert")
    marbles = marbles |> Map.put(marble_value, %{previous: aft, next: before})
    marbles = marbles |> update_in([aft, :next], fn _ -> marble_value end)
    marbles = marbles |> update_in([before, :previous], fn _ -> marble_value end)
    #IO.inspect(marbles, label: "insert-result")
    #IO.puts("")
    marbles
  end

  @spec delete(%{}, any) :: %{}
  def delete(marbles, marble_value) do
    IO.inspect(marble_value, label: "delete")
    %{next: next, previous: previous} = Map.get(marbles, marble_value)
    marbles = marbles |> update_in([next, :previous], fn _ -> previous end)
    marbles = marbles |> update_in([previous, :next], fn _ -> next end)
    Map.delete(marbles, marble_value)
    IO.inspect(marbles, label: "delete-result")
    IO.puts("")
    marbles
  end


  @spec increment_score(Game.t(), player_index()) :: Game.t()
  def increment_score(game, player_index) do
    update_in(game, [:points, player_index], &(&1 + 1))
  end

  def high_score(game) do
    Enum.max_by(game.points, fn {_k, v} -> v end) |> elem(1)
  end
end
