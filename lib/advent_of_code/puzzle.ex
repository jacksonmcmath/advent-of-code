defmodule AdventOfCode.Puzzle do
  @moduledoc """
  Solves a puzzle.
  """

  @doc "Returns the solutions for parts 1 and 2 of the puzzle."
  @callback run(String.t()) :: {any(), any()}

  @doc "Returns the solution for part 1 of the puzzle."
  @callback part_1(String.t()) :: any()

  @doc "Returns the solution for part 2 of the puzzle."
  @callback part_2(String.t()) :: any()
end
