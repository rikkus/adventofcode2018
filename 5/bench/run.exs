i = File.read!("input") |> String.trim()

Benchee.run(%{
  "react" => fn -> Aoc.react(i) end,
  "react2" => fn -> Aoc.react2(i) end,
  "react3" => fn -> Aoc.react3(i) end
}, time: 10, memory_time: 2)
