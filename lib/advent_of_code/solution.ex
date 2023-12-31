defmodule AdventOfCode.Solution do
  @moduledoc """
  Solves a puzzle.
  """

  @doc "Returns the solutions for parts 1 and 2 of the puzzle."
  @callback run() :: {any(), any()}

  @doc "Returns the solution for part 1 of the puzzle."
  @callback part_1(binary()) :: any()

  @doc "Returns the solution for part 2 of the puzzle."
  @callback part_2(binary()) :: any()
end
