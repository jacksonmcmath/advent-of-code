defmodule AdventOfCode.Y2023.D08 do
  @moduledoc """
  --- Day 8: Haunted Wasteland ---
  Puzzle Link: https://adventofcode.com/2023/day/8
  """
  @behaviour AdventOfCode.Puzzle

  defp input(), do: AdventOfCode.get_input!(2023, 8)

  @impl AdventOfCode.Puzzle
  def run(input \\ input()), do: {part_1(input), part_2(input)}

  @impl AdventOfCode.Puzzle
  def part_1(input) do
    {directions, nodes} = input |> parse_input()

    Stream.cycle(directions)
    |> Stream.with_index()
    |> Enum.reduce_while("AAA", fn {dir, idx}, node ->
      case node do
        "ZZZ" -> {:halt, idx}
        _ -> {:cont, nodes[node] |> elem(dir)}
      end
    end)
  end

  @impl AdventOfCode.Puzzle
  def part_2(input) do
    {directions, nodes} = input |> parse_input()

    starting_nodes =
      nodes
      |> Map.keys()
      |> Enum.filter(&String.ends_with?(&1, "A"))

    for node <- starting_nodes, reduce: 1 do
      lcm ->
        n = steps(directions, nodes, node, fn n -> String.ends_with?(n, "Z") end)
        div(n * lcm, Integer.gcd(n, lcm))
    end
  end

  defp parse_input(input) do
    [directions, nodes] = String.split(input, "\n\n", trim: true)

    {directions |> parse_directions(), nodes |> parse_nodes()}
  end

  defp parse_directions(directions) do
    directions
    |> String.replace("L", "0")
    |> String.replace("R", "1")
    |> String.graphemes()
    |> Enum.map(&String.to_integer/1)
  end

  defp parse_nodes(nodes) do
    nodes
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      [node, l, r] =
        line
        |> String.replace(~r/[=(),]/, "")
        |> String.split(" ", trim: true)

      {node, {l, r}}
    end)
    |> Map.new()
  end

  defp steps(seq, nodes, src, p?) do
    do_steps = fn
      [], node, len, rec -> rec.(seq, node, len, rec)
      [1 | xs], {_, r}, len, rec -> (p?.(r) && len + 1) || rec.(xs, nodes[r], len + 1, rec)
      [0 | xs], {l, _}, len, rec -> (p?.(l) && len + 1) || rec.(xs, nodes[l], len + 1, rec)
    end

    do_steps.(seq, nodes[src], 0, do_steps)
  end
end
