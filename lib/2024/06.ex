defmodule AdventOfCode.Y2024.D06 do
  @moduledoc """

  Puzzle Link: https://adventofcode.com/2024/day/6
  """
  @behaviour AdventOfCode.Puzzle

  @directions %{ "^" => {-1, 0}, ">" => {0, 1}, "v" => {1, 0}, "<" => {0, -1} }
  @right_turn %{ {-1, 0} => {0, 1}, {0, 1} => {1, 0}, {1, 0} => {0, -1}, {0, -1} => {-1, 0} }

  alias AdventOfCode.Input.Grid

  defp input(), do: AdventOfCode.get_input!(2024, 6)

  @impl AdventOfCode.Puzzle
  def run(input \\ input()), do: {part_1(input), part_2(input)}

  @impl AdventOfCode.Puzzle
  def part_1(input) do
    grid = parse_input(input)
    {cur, dir} = get_start(grid)

    traverse(grid, cur, dir, MapSet.new([cur]))
    |> MapSet.size()
  end

  @impl AdventOfCode.Puzzle
  def part_2(input) do
    grid = parse_input(input)
    {cur, dir} = get_start(grid)

    traverse(grid, cur, dir, MapSet.new([cur]))
    |> MapSet.to_list()
    |> Enum.reject(&(&1 == cur))
    |> Enum.map(fn pos ->
      grid
      |> Map.replace(pos, "#")
      |> loop?(cur, dir, MapSet.new([]))
    end)
    |> Enum.count(&(&1 == true))
  end

  defp parse_input(input) do
    input |> Grid.from_text()
  end

  defp get_start(grid) do
    grid
    |> Enum.filter(fn {_pos, value} -> value in ~w[^ > v <] end)
    |> Enum.map(fn {pos, value} -> {pos, @directions[value]} end)
    |> hd()
  end

  defp traverse(grid, {x, y} = cur, {dx, dy} = dir, visited) do
    cond do
      # fell off the map
      not Map.has_key?(grid, cur) ->
        visited

      # obstacle ahead, turn right
      Map.get(grid, {x + dx, y + dy}) == "#" ->
        traverse(grid, cur, @right_turn[dir], visited)

      # move forward
      true ->
        traverse(grid, {x + dx, y + dy}, dir, MapSet.put(visited, cur))
    end
  end

  defp loop?(grid, {x, y} = cur, {dx, dy} = dir, visited) do
    cond do
      # stuck in a loop
      MapSet.member?(visited, {cur, dir}) ->
        true

      # fell off the map
      not Map.has_key?(grid, cur) ->
        false

      # obstacle ahead, turn right
      Map.get(grid, {x + dx, y + dy}) == "#" ->
        loop?(grid, cur, @right_turn[dir], visited)

      # move forward
      true ->
        loop?(grid, {x + dx, y + dy}, dir, MapSet.put(visited, {cur, dir}))
    end
  end
end
