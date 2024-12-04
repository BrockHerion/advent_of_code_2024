defmodule Day2.Part2 do
  def solve(lists) do
    # Loop through each sub-array and return an atom with the result
    results = Enum.map(lists, &solve_sub_list/1)

    IO.puts("Result: #{Enum.count(results, &(&1 == :safe))}")
  end

  defp solve_sub_list(list) do
    initial_trend = Day2.Utils.get_initial_trend(list)
    filtered_list = dampen_list(list, initial_trend)

    if Day2.Utils.has_bad_level?(filtered_list, initial_trend) do
      IO.inspect(filtered_list, label: "Bad Level", charlists: :as_lists)
      :unsafe
    else
      IO.inspect(filtered_list, label: "Good Level", charlists: :as_lists)
      :safe
    end
  end

  defp dampen_list(list, trend) do
    list_len = length(list)

    list
    |> Enum.with_index()
    |> Enum.reduce_while(list, fn {current, index}, _acc ->
      if index < list_len - 1 do
        next = Enum.at(list, index + 1)

        if not Day2.Utils.valid_adjacent_pairs?(current, next, trend) do
          filtered_list = List.delete_at(list, index)
          {:halt, filtered_list}
        else
          {:cont, nil}
        end
      else
        {:cont, nil}
      end
    end)
    |> case do
      # No bad levels, return the original list
      nil -> list
      # Return filtered list
      filtered_list -> filtered_list
    end
  end
end
