defmodule Day1.Application do
  use Application

  def start(_type, _args) do
    # Retrieve the file path from command-line arguments
    case System.argv() do
      [file_path, "part1"] ->
        run_part(:part1, file_path)

      [file_path, "part2"] ->
        run_part(:part2, file_path)

      _ ->
        IO.puts("Usage: mix run --no-halt <file_path>")
    end

    {:ok, self()}
  end

  defp run_part(part, file_path) do
    tuples = Day1.Utils.process_file(file_path)

    case part do
      :part1 ->
        result = Day1.Part1.solve(tuples)
        IO.inspect(result, label: "Part 1 Solution")

      :part2 ->
        result = Day1.Part2.solve(tuples)
        IO.inspect(result, label: "Part 2 Solution")
    end
  end
end
