defmodule AdventOfCode.Y2024.D02 do
  @moduledoc """
  --- Day 2: Red-Nosed Reports ---
  Puzzle Link: https://adventofcode.com/2024/day/2
  """
  @behaviour AdventOfCode.Puzzle

  defp input(), do: AdventOfCode.get_input!(2024, 2)

  @impl AdventOfCode.Puzzle
  def run(input \\ input()), do: {part_1(input), part_2(input)}

  @impl AdventOfCode.Puzzle
  def part_1(input) do
    input
    |> parse_input()
    |> Enum.map(&safe_report_with_tolerance?/1)
    |> Enum.count(&(&1 == true))
  end

  @impl AdventOfCode.Puzzle
  def part_2(input) do
    input
    |> parse_input()
    |> Enum.map(&safe_report_with_tolerance?(&1, 1))
    |> Enum.count(&(&1 == true))
  end

  defp parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_line/1)
  end

  defp parse_line(line) do
    line
    |> String.split()
    |> Enum.map(&String.to_integer/1)
  end

  defp safe_report?(report) when length(report) < 2, do: true

  defp safe_report?(report) do
    differences =
      report
      |> Enum.chunk_every(2, 1, :discard)
      |> Enum.map(fn [a, b] -> b - a end)

    all_increasing = Enum.all?(differences, &(&1 > 0 and &1 <= 3))
    all_decreasing = Enum.all?(differences, &(&1 < 0 and &1 >= -3))

    all_increasing or all_decreasing
  end

  defp safe_report_with_tolerance?(report, tolerance \\ 0)
  defp safe_report_with_tolerance?(_report, tolerance) when tolerance < 0, do: false
  defp safe_report_with_tolerance?(report, tolerance) do
    if safe_report?(report) do
      true
    else
      0..length(report) - 1
      |> Enum.any?(fn index ->
        report
        |> List.delete_at(index)
        |> safe_report_with_tolerance?(tolerance - 1)
      end)
    end
  end

end
