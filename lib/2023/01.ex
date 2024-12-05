defmodule AdventOfCode.Y2023.D01 do
  @moduledoc """
  --- Day 1: Trebuchet?! ---
  Puzzle Link: https://adventofcode.com/2023/day/1
  """
  @behaviour AdventOfCode.Puzzle

  defp input(), do: AdventOfCode.get_input!(2023, 1)

  @impl AdventOfCode.Puzzle
  def run(input \\ input()), do: {part_1(input), part_2(input)}

  @impl AdventOfCode.Puzzle
  def part_1(input) do
    input
    |> String.replace(~r"[^\d\n]", "")
    |> String.split("\n")
    |> Enum.map(&extract_calibration_value/1)
    |> Enum.sum()
  end

  @impl AdventOfCode.Puzzle
  def part_2(input) do
    input
    |> replace_words_with_numbers()
    |> part_1()
  end

  defp extract_calibration_value(""), do: 0

  defp extract_calibration_value(input) do
    first = String.first(input)
    last = String.last(input)
    String.to_integer(first <> last)
  end

  defp replace_words_with_numbers(text) do
    text
    |> String.replace("one", "o1e")
    |> String.replace("two", "t2o")
    |> String.replace("three", "t3e")
    |> String.replace("four", "f4r")
    |> String.replace("five", "f5e")
    |> String.replace("six", "s6x")
    |> String.replace("seven", "s7n")
    |> String.replace("eight", "e8t")
    |> String.replace("nine", "n9e")
  end
end
