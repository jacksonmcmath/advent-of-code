defmodule AdventOfCode.Y2023.D03 do
  @moduledoc """
  --- Day 3: Gear Ratios ---
  Puzzle Link: https://adventofcode.com/2023/day/3
  """
  @behaviour AdventOfCode.Puzzle

  alias AdventOfCode.Input.Grid

  defp input(), do: AdventOfCode.get_input!(2023, 3)

  @impl AdventOfCode.Puzzle
  def run(input \\ input()), do: {part_1(input), part_2(input)}

  @impl AdventOfCode.Puzzle
  def part_1(input) do
    input
    |> parse_input()
    |> Enum.reduce(0, fn {part_num, _, _}, acc -> acc + part_num end)
  end

  @impl AdventOfCode.Puzzle
  def part_2(input) do
    input
    |> parse_input()
    |> Enum.map(fn {part_num, _, gears} -> {part_num, Enum.uniq(gears)} end)
    |> Enum.flat_map(fn {part_num, gears} -> Enum.map(gears, &{&1, part_num}) end)
    |> Enum.group_by(fn {gear, _} -> gear end, fn {_, part_num} -> part_num end)
    |> Enum.reduce(0, fn
      {_, [a, b]}, acc -> a * b + acc
      _, acc -> acc
    end)
  end

  defp parse_input(input) do
    grid = Grid.from_text(input)

    0..(grid |> Map.keys() |> Enum.max() |> elem(0))
    |> Enum.flat_map(&collect_all(grid, &1))
    |> Enum.filter(fn {_, part?, _} -> part? == true end)
  end

  defp part?(grid, pos) do
    pos
    |> Grid.surrounding_8()
    |> Enum.map(&grid[&1])
    |> Enum.reject(&(is_nil(&1) || MapSet.member?(MapSet.new(~w[. 1 2 3 4 5 6 7 8 9 0]), &1)))
    |> Enum.empty?()
    |> Kernel.not()
  end

  defp get_gears(grid, pos) do
    pos
    |> Grid.surrounding_8()
    |> Enum.filter(&(grid[&1] == "*"))
  end

  defp collect_all(grid, row), do: collect_all(grid, row, 0, [])

  defp collect_all(grid, row, col, numbers) do
    case collect_one(grid, {row, col}) do
      {:halt, "", _, _} ->
        numbers

      {_, "", _, _} ->
        collect_all(grid, row, col + 1, numbers)

      {:halt, number, part?, gears} ->
        [{String.to_integer(number), part?, gears} | numbers]

      {{:cont, next}, number, part?, gears} ->
        collect_all(grid, row, next, [{String.to_integer(number), part?, gears} | numbers])
    end
  end

  defp collect_one(grid, pos), do: collect_one(grid[pos], grid, pos, "", false, [])

  defp collect_one(cur, grid, {x, y}, digits, part?, gears) when cur in ~w[1 2 3 4 5 6 7 8 9 0] do
    collect_one(
      grid[{x, y + 1}],
      grid,
      {x, y + 1},
      digits <> cur,
      part? || part?(grid, {x, y}),
      get_gears(grid, {x, y}) ++ gears
    )
  end

  defp collect_one(nil, _, {_, _}, digits, part?, gears), do: {:halt, digits, part?, gears}
  defp collect_one(_, _, {_, y}, digits, part?, gears), do: {{:cont, y}, digits, part?, gears}
end
