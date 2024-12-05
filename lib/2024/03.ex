defmodule AdventOfCode.Y2024.D03 do
  @moduledoc """
  --- Day 3: Mull It Over ---
  Puzzle Link: https://adventofcode.com/2024/day/3
  """
  @behaviour AdventOfCode.Puzzle

  @part_1_instructions ~r/mul\(\d{1,3},\d{1,3}\)/

  @part_2_instructions ~r/mul\(\d{1,3},\d{1,3}\)|do\(\)|don't\(\)/

  defp input(), do: AdventOfCode.get_input!(2024, 3)

  @impl AdventOfCode.Puzzle
  def run(input \\ input()), do: {part_1(input), part_2(input)}

  @impl AdventOfCode.Puzzle
  def part_1(input) do
    input
    |> parse_input()
    |> Enum.map(&parse_instruction/1)
    |> Enum.sum()
  end

  @impl AdventOfCode.Puzzle
  def part_2(input) do
    input
    |> parse_input(@part_2_instructions)
    |> Enum.reduce({[], true}, fn instruction, {result, collect?} ->
      cond do
        instruction == "do()" -> {result, true} # start collecting instructions
        instruction == "don't()" -> {result, false} # stop collecting instructions
        !collect? -> {result, collect?} # do nothing when should not collect
        true -> {[instruction | result], collect?} # collect the instruction
      end
    end)
    |> elem(0)
    |> Enum.map(&parse_instruction/1)
    |> Enum.sum()
  end

  defp parse_input(input, instruction_regex \\ @part_1_instructions) do
    instruction_regex
    |> Regex.scan(input)
    |> List.flatten()
  end

  defp parse_instruction(instruction) do
    [_operation, rest] = String.split(instruction, "(")
    [lhs, rest] = String.split(rest, ",")
    [rhs, _rest] = String.split(rest, ")")

    String.to_integer(lhs) * String.to_integer(rhs)
  end
end
