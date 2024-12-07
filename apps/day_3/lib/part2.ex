defmodule Day3.Part2 do
  def solve(lines) do
    # Context carries from line to line, so we need to keep track of it
    {matches, _} =
      Enum.reduce(lines, {[], :allow}, fn line, {acc_matches, context} ->
        process_line(line, context)
        |> case do
          {line_matches, new_context} ->
            {acc_matches ++ line_matches, new_context}
        end
      end)

    matches
    |> Enum.reduce(0, fn {n, m}, acc -> acc + n * m end)
  end

  def process_line(line, initial_context) do
    mul_pattern = ~r/mul\((\d+),(\d+)\)/
    control_pattern = ~r/mul\((\d+),(\d+)\)|do\(\)|don't\(\)/

    # Get all matching do, don't and mul patterns
    Regex.scan(control_pattern, line)
    |> Enum.reduce({[], initial_context}, fn string, {matches, context} ->
      cond do
        # Match control patterns and adjust context
        string == ["do()"] ->
          {matches, :allow}

        string == ["don't()"] ->
          {matches, :deny}

        # Match valid mul(n,m) patterns and add to matches if context allows
        Regex.match?(mul_pattern, Enum.at(string, 0)) and context == :allow ->
          case Regex.run(mul_pattern, Enum.at(string, 0)) do
            [_, n, m] ->
              {[{String.to_integer(n), String.to_integer(m)} | matches], context}

            _ ->
              {matches, context}
          end

        # Ignore everything else
        true ->
          {matches, context}
      end
    end)
  end
end
