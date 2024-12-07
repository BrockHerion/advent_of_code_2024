defmodule Day3.Utils do
  def process_file(file_path) do
    File.stream!(file_path)
    # Cleanup each line
    |> Stream.map(&String.trim/1)
    # Parse each line and add to a list
    |> Enum.to_list()
  end
end
