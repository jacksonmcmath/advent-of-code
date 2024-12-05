defmodule AdventOfCode.Y2024.D04 do
  @moduledoc """
  --- Day 4: Ceres Search ---
  Puzzle Link: https://adventofcode.com/2024/day/4
  """
  @behaviour AdventOfCode.Puzzle

  @directions [{1, 0}, {-1, 0}, {0, 1}, {0, -1}, {1, 1}, {-1, -1}, {1, -1}, {-1, 1}]
  @diagonals [{1, 1}, {-1, -1}, {1, -1}, {-1, 1}]

  alias AdventOfCode.Input.Grid

  defp input(), do: AdventOfCode.get_input!(2024, 4)

  @impl AdventOfCode.Puzzle
  def run(input \\ input()), do: {part_1(input), part_2(input)}

  @impl AdventOfCode.Puzzle
  def part_1(input) do
    ws = parse_input(input)

    for {pos, val} <- ws,
        val == "X",
        direction <- @directions,
        match_xmas?(ws, pos, direction) do
      {pos, direction}
    end
    |> length()
  end

  @impl AdventOfCode.Puzzle
  def part_2(input) do
    ws = parse_input(input)

    for {pos, val} <- ws,
        val == "A",
        match_x_mas?(ws, pos) do
      {pos}
    end
    |> length()
  end

  defp parse_input(input) do
    input |> Grid.from_text()
  end

  defp match_xmas?(grid, {row, col}, {dx, dy}) do
    ~w[X M A S]
    |> Enum.with_index()
    |> Enum.all?(fn {char, i} ->
      next = {row + i * dx, col + i * dy}
      Map.get(grid, next) == char
    end)
  end

  defp match_x_mas?(grid, {row, col}) do
    @diagonals
    |> Enum.map(fn {dx, dy} ->
      Map.get(grid, {row + dx, col + dy})
    end)
    |> Enum.split(2)
    |> Tuple.to_list()
    |> Enum.map(&Enum.sort/1)
    |> Enum.all?(&(&1 == ["M", "S"]))
  end
end
