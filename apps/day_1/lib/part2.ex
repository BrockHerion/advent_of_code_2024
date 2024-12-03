defmodule Day1.Part2 do
  def solve(tuples) do
    {list_a, list_b} = Day1.Utils.split_tuples(tuples)

    count_map = get_count_map({list_a, list_b})

    sum =
      list_a
      |> Enum.map(fn key -> key * Map.get(count_map, key, 0) end)
      |> Enum.sum()

    IO.puts("Sum: #{sum}")
  end

  defp get_count_map({list_a, list_b}) do
    frequencies = Enum.frequencies(list_b)

    Enum.uniq(list_a)
    |> Enum.reduce(%{}, fn key, acc ->
      count = Map.get(frequencies, key, 0)
      Map.put(acc, key, count)
    end)
  end
end
