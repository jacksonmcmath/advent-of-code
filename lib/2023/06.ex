defmodule AdventOfCode.Y2023.D06 do
  @moduledoc """
  --- Day 6: Wait For It ---
  Puzzle Link: https://adventofcode.com/2023/day/6
  """
  @behaviour AdventOfCode.Solution

  defp input(), do: AdventOfCode.Input.get!(2023, 6)

  @impl AdventOfCode.Solution
  def run(), do: {part_1(input()), part_2(input())}

  @impl AdventOfCode.Solution
  def part_1(input) do
    input
    |> parse_input()
    |> Enum.map(fn {time, dist} ->
      time
      |> calculate_distance()
      |> Enum.filter(&(&1 > dist))
    end)
    |> Enum.map(&Enum.count/1)
    |> Enum.reduce(1, &(&1 * &2))
  end

  @impl AdventOfCode.Solution
  def part_2(input) do
    {time, dist} = input |> parse_input_correctly()

    time
    |> calculate_distance()
    |> Enum.count(&(&1 > dist))
  end

  defp parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      line
      |> String.split(~r/\s+/)
      |> tl()
      |> Enum.map(&String.to_integer/1)
    end)
    |> Enum.zip()
  end

  defp parse_input_correctly(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      line
      |> String.replace(~r/\s/, "")
      |> String.split(":")
      |> Enum.at(1)
      |> String.to_integer()
    end)
    |> List.to_tuple()
  end

  defp calculate_distance(total_time) when total_time >= 0 do
    0..total_time
    |> Enum.map(&(total_time * &1 - &1 ** 2))
  end
end
