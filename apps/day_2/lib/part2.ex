defmodule Day2.Part2 do
  def solve(lists) do
    # Loop through each sub-array and return an atom with the result
    Enum.map(lists, &solve_sub_list/1)
    |> Enum.count(&(&1 == :safe))
  end

  defp solve_sub_list(list) do
    initial_trend = Day2.Utils.get_initial_trend(list)

    if not Day2.Utils.has_bad_level?(list, initial_trend) do
      :safe
    else
      filtered_list = dampen_list(list)
      new_trend = Day2.Utils.get_initial_trend(filtered_list)

      if Day2.Utils.has_bad_level?(filtered_list, new_trend) do
        IO.inspect(filtered_list, label: "Bad Level", charlists: :as_lists)
        :unsafe
      else
        IO.inspect(filtered_list, label: "Good Level", charlists: :as_lists)
        :safe
      end
    end
  end

  defp dampen_list(list) do
    list
    |> Enum.with_index()
    |> Enum.reduce_while(list, fn {_current, index}, _acc ->
      # Create a new list with the current index removed
      new_list = List.delete_at(list, index)
      new_trend = Day2.Utils.get_initial_trend(new_list)

      # Check if removing this element creates a valid list
      if not Day2.Utils.has_bad_level?(new_list, new_trend) do
        # Return the valid list
        {:halt, new_list}
      else
        # Continue checking other indices
        {:cont, nil}
      end
    end)
    |> case do
      # No bad levels, return the original list
      nil -> list
      # Return filtered list
      new_list -> new_list
    end
  end
end
