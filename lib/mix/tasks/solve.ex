defmodule Mix.Tasks.Solve do
  @moduledoc """
  Solves the puzzle for the given year and day.
  """
  use Mix.Task

  @impl Mix.Task
  def run(argv) do
    {year, day} = AdventOfCode.parse_args!(argv)

    case AdventOfCode.solve(year, day) do
      {:ok, {part_1, part_2}} -> Mix.shell().info("Part 1: #{part_1}\tPart 2: #{part_2}")
      {:error, :not_yet_solved} -> Mix.shell().error("#{year}/#{day} is not solved yet")
      {:error, :invalid_args} -> Mix.shell().error("Invalid year/day: #{year}/#{day}")
    end
  end
end
