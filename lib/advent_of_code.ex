defmodule AdventOfCode do
  @moduledoc """
  Solves puzzles for the given year and day.
  """

  @latest_year 2023

  @typedoc "A valid Advent of Code year."
  @type year() :: 2015..2023

  @typedoc "A valid Advent of Code day."
  @type day() :: 1..25

  @doc "Returns the latest solved year."
  @spec get_latest_year() :: year()
  def get_latest_year(), do: @latest_year

  @doc "Solves the puzzle for the given year and day."
  @spec solve(day()) :: {:ok, any()} | {:error, atom()}
  @spec solve(year(), day()) :: {:ok, any()} | {:error, atom()}
  def solve(year \\ @latest_year, day) do
    {:ok, Module.concat([AdventOfCode, get_year_module(year), get_day_module(day)]).run()}
  rescue
    _ in FunctionClauseError -> {:error, :invalid_args}
    _ in UndefinedFunctionError -> {:error, :not_yet_solved}
  end

  defp get_year_module(year) when year in 2015..@latest_year do
    "Y" <> Integer.to_string(year)
  end

  defp get_day_module(day) when day in 1..25 do
    day
    |> Integer.to_string()
    |> String.pad_leading(2, "0")
    |> then(fn day -> "D" <> day end)
  end
end
