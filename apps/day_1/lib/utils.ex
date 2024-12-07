defmodule Day1.Utils do
  def process_file(file_path) do
    File.stream!(file_path)
    # Cleanup each line
    |> Stream.map(&String.trim/1)
    # Parse each line and add to a list
    |> Enum.reduce({[], []}, fn line, {list_a, list_b} ->
      if validate_line?(line) do
        [a, b] = String.split(line) |> Enum.map(&String.to_integer/1)
        {[a | list_a], [b | list_b]}
      else
        {list_a, list_b}
      end
    end)
    |> then(fn {list_a, list_b} -> {Enum.reverse(list_a), Enum.reverse(list_b)} end)
  end

  defp validate_line?(line) do
    Regex.match?(~r/^\d+\s+\d+$/, line)
  end
end
