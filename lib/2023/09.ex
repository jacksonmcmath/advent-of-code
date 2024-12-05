defmodule AdventOfCode.Y2023.D09 do
  @moduledoc """
  --- Day 9: Mirage Maintenance ---
  Puzzle Link: https://adventofcode.com/2023/day/9
  """
  @behaviour AdventOfCode.Puzzle

  defp input(), do: AdventOfCode.get_input!(2023, 9)

  @impl AdventOfCode.Puzzle
  def run(input \\ input()), do: {part_1(input), part_2(input)}

  @impl AdventOfCode.Puzzle
  def part_1(input) do
    input
    |> parse_input()
    |> Enum.map(&extrapolate_last/1)
    |> Enum.sum()
  end

  @impl AdventOfCode.Puzzle
  def part_2(input) do
    input
    |> parse_input()
    |> Enum.map(&extrapolate_first/1)
    |> Enum.sum()
  end

  defp parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      line
      |> String.split(" ", trim: true)
      |> Enum.map(&String.to_integer/1)
    end)
  end

  defp extrapolate_last(values) when length(values) > 1 do
    values |> differences() |> extrapolate_last() |> Kernel.+(List.last(values))
  end

  defp extrapolate_last([value]), do: value

  defp extrapolate_first(values) when length(values) > 1 do
    dif = values |> differences() |> extrapolate_first()
    List.first(values) - dif
  end

  defp extrapolate_first([value]), do: value

  defp differences(values) when is_list(values) do
    Enum.zip(values, Enum.drop(values, 1)) |> Enum.map(fn {a, b} -> b - a end)
  end
end
