defmodule Day2.Utils do
  def process_file(file_path) do
    File.stream!(file_path)
    |> Stream.map(&String.trim/1)
    |> Stream.map(&String.split(&1, " "))
    |> Stream.map(fn list -> Enum.map(list, &String.to_integer/1) end)
    |> Enum.to_list()
  end

  def has_bad_level?(list, trend) do
    conforms_to_order = conforms_to_order?(list)

    if not conforms_to_order do
      true
    else
      list_len = length(list)

      list
      |> Enum.with_index()
      |> Enum.any?(fn {current, index} ->
        if index < list_len - 1 do
          next = Enum.at(list, index + 1)
          not valid_adjacent_pairs?(current, next, trend)
        else
          false
        end
      end)
    end
  end

  def valid_adjacent_pairs?(current, next, trend) do
    abs(current - next) <= 3 and current != next and
      ((trend == :inc and current < next) or (trend == :dec and current > next))
  end

  def conforms_to_order?(list) do
    is_increasing?(list) or is_decreasing?(list)
  end

  def is_increasing?(list) do
    Enum.zip(list, tl(list))
    |> Enum.all?(fn {a, b} -> a <= b end)
  end

  def is_decreasing?(list) do
    Enum.zip(list, tl(list))
    |> Enum.all?(fn {a, b} -> a >= b end)
  end

  def get_initial_trend(list) do
    if length(list) < 2 do
      :inc
    end

    [a, b | _] = list

    cond do
      a < b -> :inc
      a > b -> :dec
      true -> :inc
    end
  end
end
