defmodule AdventOfCode.Y2024.D01 do
  @moduledoc """
  --- Day 1: Historian Hysteria ---
  Puzzle Link: https://adventofcode.com/2024/day/1
  """
  @behaviour AdventOfCode.Puzzle

  defp input(), do: AdventOfCode.get_input!(2024, 1)

  @impl AdventOfCode.Puzzle
  def run(input \\ input()), do: {part_1(input), part_2(input)}

  @impl AdventOfCode.Puzzle
  def part_1(input) do
    input
    |> parse_input()
    |> Tuple.to_list()
    |> Enum.map(&Enum.sort/1)
    |> Enum.zip()
    |> Enum.map(fn {a, b} -> abs(a - b) end)
    |> Enum.sum()
  end

  @impl AdventOfCode.Puzzle
  def part_2(input) do
    {one, two} = parse_input(input)

    one
    |> Enum.map(fn el ->
      two
      |> Enum.frequencies()
      |> Map.get(el, 0)
      |> (&(&1 * el)).()
    end)
    |> Enum.sum()
  end

  defp parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_line/1)
    |> Enum.unzip()
  end

  defp parse_line(line) do
    line
    |> String.split()
    |> Enum.map(&String.to_integer/1)
    |> List.to_tuple()
  end
end
