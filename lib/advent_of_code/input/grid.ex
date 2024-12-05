defmodule AdventOfCode.Input.Grid do
  @moduledoc """
  Helpers for grids and two dimensional data.
  """

  @type t(value) :: %{optional({number(), number()}) => value}

  @doc """
  Converts a list of lists into a map of coordinates to values.
  """
  @spec from_list([[any()]]) :: t(any())
  def from_list(matrix) when is_list(matrix) do
    for {row, r} <- Enum.with_index(matrix),
        {val, c} <- Enum.with_index(row),
        into: %{} do
      {{r, c}, val}
    end
  end

  @doc """
  Coverts a block of text into a map of coordinates to characters.
  """
  @spec from_text(String.t(), boolean()) :: t(String.t())
  def from_text(text, trim \\ true) do
    text
    |> String.split("\n", trim: trim)
    |> Enum.map(&String.graphemes/1)
    |> from_list()
  end

  @doc """
  Returns the coordinates of the 8 positions surrounding the input.
  """
  @spec surrounding_8({number(), number()}) :: [{number(), number()}, ...]
  def surrounding_8({x, y}) do
    [{1, 0}, {-1, 0}, {0, 1}, {0, -1}, {1, 1}, {-1, -1}, {1, -1}, {-1, 1}]
    |> Enum.map(fn {dx, dy} -> {x + dx, y + dy} end)
  end

  @doc """
  Returns the coordinates of the 8 positions surrounding the input.
  """
  @spec surrounding_4({number(), number()}) :: [{number(), number()}, ...]
  def surrounding_4({x, y}) do
    [{1, 0}, {-1, 0}, {0, 1}, {0, -1}]
    |> Enum.map(fn {dx, dy} -> {x + dx, y + dy} end)
  end
end
