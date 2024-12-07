defmodule Day3.Part1 do
  def solve(lines) do
    pattern = ~r/mul\((\d+),(\d+)\)/

    lines
    # Get all matching entries in each line
    |> Enum.flat_map(fn string ->
      Regex.scan(pattern, string)
    end)
    # Get n and m as integers
    |> Enum.map(fn [_, a, b] -> {String.to_integer(a), String.to_integer(b)} end)
    # Multiply n and m and sum the results
    |> Enum.reduce(0, fn {n, m}, acc -> acc + n * m end)
  end
end
