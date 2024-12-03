defmodule Day1.Utils do
  def process_file(file_path) do
    File.stream!(file_path)
    # Cleanup each line
    |> Stream.map(&String.trim/1)
    # Validate each line
    |> Stream.filter(&validate_line?/1)
    # Parse each line to a tuple
    |> Enum.map(&line_to_tuple/1)
  end

  defp validate_line?(line) do
    Regex.match?(~r/^\d+\s+\d+$/, line)
  end

  defp line_to_tuple(line) do
    [a, b] = String.split(line) |> Enum.map(&String.to_integer/1)
    {a, b}
  end

  def split_tuples(tuples) do
    Enum.reduce(tuples, {[], []}, fn {a, b}, {list_a, list_b} ->
      # Add values to their respective lists
      {[a | list_a], [b | list_b]}
    end)
    |> then(fn {list_a, list_b} -> {Enum.reverse(list_a), Enum.reverse(list_b)} end)
  end
end
