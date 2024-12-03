defmodule Day1.Part1 do
  def solve(tuples) do
    sum =
      tuples
      |> Day1.Utils.split_tuples()
      |> sort_lists()
      |> subtract_lists()
      |> Enum.sum()

    IO.puts("Sum: #{sum}")
  end

  defp sort_lists({list_a, list_b}) do
    {Enum.sort(list_a), Enum.sort(list_b)}
  end

  defp subtract_lists({list_a, list_b}) do
    Enum.zip(list_a, list_b)
    |> Enum.map(fn {a, b} -> abs(a - b) end)
  end
end
