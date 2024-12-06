defmodule AdventOfCode.Y2024.D05 do
  @moduledoc """
  --- Day 5: Print Queue ---
  Puzzle Link: https://adventofcode.com/2024/day/5
  """
  @behaviour AdventOfCode.Puzzle

  defp input(), do: AdventOfCode.get_input!(2024, 5)

  @impl AdventOfCode.Puzzle
  def run(input \\ input()), do: {part_1(input), part_2(input)}

  @impl AdventOfCode.Puzzle
  def part_1(input) do
    {rules, updates} = parse_input(input)

    updates
    |> Enum.filter(&in_order?(&1, rules))
    |> Enum.map(&Enum.at(&1, div(length(&1), 2)))
    |> Enum.sum()
  end

  @impl AdventOfCode.Puzzle
  def part_2(input) do
    {rules, updates} = parse_input(input)

    updates
    |> Enum.filter(&(!in_order?(&1, rules)))
    |> Enum.map(&put_in_order(&1, rules))
    |> Enum.map(&Enum.at(&1, div(length(&1), 2)))
    |> Enum.sum()
  end

  defp parse_input(input) do
    [rules, updates] = input |> String.split("\n\n", trim: true)

    {parse_rules(rules), parse_updates(updates)}
  end

  defp parse_rules(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      line
      |> String.split("|", trim: true)
      |> Enum.map(&String.to_integer/1)
      |> List.to_tuple()
    end)
  end

  defp parse_updates(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      line
      |> String.split(",", trim: true)
      |> Enum.map(&String.to_integer/1)
    end)
  end

  defp in_order?(update, rules) do
    for {a, b} <- rules, a in update and b in update do
      Enum.find_index(update, &(&1 == a)) < Enum.find_index(update, &(&1 == b))
    end
    |> Enum.all?()
  end

  defp put_in_order(update, []), do: update

  defp put_in_order(update, rules) do
    Enum.sort(update, fn n1, n2 ->
      rule = Enum.find(rules, fn rule -> rule == {n1, n2} or rule == {n2, n1} end)
      is_nil(rule) or rule == {n1, n2}
    end)
  end
end
