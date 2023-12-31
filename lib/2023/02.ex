defmodule AdventOfCode.Y2023.D02 do
  @moduledoc """
  --- Day 2: Cube Conundrum ---
  Puzzle Link: https://adventofcode.com/2023/day/2
  """
  @behaviour AdventOfCode.Solution

  defp input(), do: AdventOfCode.Input.get!(2023, 2)

  @impl AdventOfCode.Solution
  def run(), do: {part_1(input()), part_2(input())}

  @impl AdventOfCode.Solution
  def part_1(input) do
    input
    |> parse_input()
    |> Enum.with_index()
    |> Enum.reduce(0, fn {game, index}, acc ->
      if valid_game?(game), do: acc + index + 1, else: acc
    end)
  end

  @impl AdventOfCode.Solution
  def part_2(input) do
    input
    |> parse_input()
    |> Enum.map(&calculate_power/1)
    |> Enum.sum()
  end

  defp parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_line/1)
  end

  defp parse_line(input) do
    input
    |> String.split(":", trim: true)
    |> Enum.at(1)
    |> String.split(";", trim: true)
    |> Enum.map(&extract_color_map/1)
  end

  defp extract_color_map(input) do
    input
    |> String.split(", ", trim: true)
    |> Enum.map(fn color_count ->
      split = String.split(color_count, " ", trim: true)
      count = split |> List.first() |> String.to_integer()
      color = split |> List.last()
      %{color => count}
    end)
    |> Enum.reduce(%{}, &Map.merge(&1, &2))
  end

  defp valid_game?(game) do
    game
    |> Enum.map(&valid_drawing?/1)
    |> Enum.all?()
  end

  defp valid_drawing?(%{"red" => r}) when r > 12, do: false
  defp valid_drawing?(%{"green" => g}) when g > 13, do: false
  defp valid_drawing?(%{"blue" => b}) when b > 14, do: false
  defp valid_drawing?(_), do: true

  defp calculate_power(game) do
    r = minimum_color(game, "red")
    g = minimum_color(game, "green")
    b = minimum_color(game, "blue")
    r * g * b
  end

  defp minimum_color(game, color) do
    game
    |> Enum.map(&Map.get(&1, color, 0))
    |> Enum.max()
  end
end
