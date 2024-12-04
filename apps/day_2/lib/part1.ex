defmodule Day2.Part1 do
  def solve(lists) do
    # Loop through each sub-array and return an atom with the result
    results = Enum.map(lists, &solve_sub_list/1)

    Enum.each(results, &IO.inspect(&1, label: "Result"))

    IO.puts("Result: #{Enum.count(results, &(&1 == :safe))}")
  end

  defp solve_sub_list(list) do
    initial_trend = Day2.Utils.get_initial_trend(list)

    if Day2.Utils.has_bad_level?(list, initial_trend) do
      :unsafe
    else
      :safe
    end
  end
end
