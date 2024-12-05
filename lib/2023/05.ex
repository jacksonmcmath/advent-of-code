defmodule AdventOfCode.Y2023.D05 do
  @moduledoc """
  --- Day 5: If You Give A Seed A Fertilizer ---
  Puzzle Link: https://adventofcode.com/2023/day/5
  """
  @behaviour AdventOfCode.Puzzle

  defp input(), do: AdventOfCode.get_input!(2023, 5)

  @impl AdventOfCode.Puzzle
  def run(input \\ input()), do: {part_1(input), part_2(input)}

  @impl AdventOfCode.Puzzle
  def part_1(input) do
    {seeds, mappings} = parse_input(input)

    seeds
    |> Enum.map(fn seed -> Enum.reduce(mappings, seed, &get_destination/2) end)
    |> Enum.min()
  end

  @impl AdventOfCode.Puzzle
  def part_2(input) do
    {seeds, mappings} = parse_input(input)

    mappings
    |> Enum.reduce(parse_seeds_as_ranges(seeds), fn mapping, sources ->
      Enum.flat_map(sources, &get_destinations(mapping, &1))
    end)
    |> Enum.min()
    |> elem(0)
  end

  defp parse_input(input) do
    ["seeds: " <> seeds | maps] = String.split(input, "\n\n", trim: true)

    {
      seeds |> String.split(" ", trim: true) |> Enum.map(&String.to_integer/1),
      maps |> parse_mappings()
    }
  end

  defp parse_seeds_as_ranges(seeds) do
    seeds
    |> Enum.chunk_every(2)
    |> Enum.map(fn [start, length] -> {start, start + length - 1} end)
  end

  defp parse_mappings(mappings) do
    for mapping <- mappings do
      with [_, ranges] <- String.split(mapping, " map:\n", trim: true) do
        ranges
        |> String.split("\n", trim: true)
        |> Enum.map(fn range ->
          range
          |> String.split(" ", trim: true)
          |> Enum.map(&String.to_integer/1)
        end)
        |> Enum.reduce(:gb_trees.empty(), fn [dst, src, len], tree ->
          :gb_trees.insert(
            {src, src + len - 1},
            {dst, dst + len - 1},
            tree
          )
        end)
      end
    end
  end

  defp get_destination(mapping, source) do
    mapping
    |> :gb_trees.iterator()
    |> Stream.unfold(fn iterator ->
      case :gb_trees.next(iterator) do
        :none ->
          nil

        {source_range, destination_range, iterator} ->
          {{source_range, destination_range}, iterator}
      end
    end)
    |> Enum.find({{0, 0}, {0, 0}}, fn {{a, b}, _} -> source in a..b end)
    |> then(fn {{a, _}, {c, _}} -> c + source - a end)
  end

  defp get_destinations(mapping, range) do
    mapping
    |> :gb_trees.iterator()
    |> get_destinations(range, [])
  end

  defp get_destinations(iterator, {a, b}, acc),
    do: build_destinations(:gb_trees.next(iterator), {a, b}, acc)

  # ¯\_(ツ)_/¯
  defp build_destinations(:none, {a, b}, acc), do: [{a, b} | acc]

  #            a -- b
  # si -- sf
  defp build_destinations({{_, sf}, {_, _}, iter}, {a, b}, acc) when sf < a,
    do: get_destinations(iter, {a, b}, acc)

  # a -- b
  #         si -- sf
  defp build_destinations({{si, _}, {_, _}, _}, {a, b}, acc) when si > b, do: [{a, b} | acc]

  #      a -- b
  #  si -------- sf
  defp build_destinations({{si, sf}, {di, _}, _}, {a, b}, acc) when si <= a and sf >= b,
    do: [{a - si + di, b - si + di} | acc]

  #  a ---------- b
  #  si -- sf
  defp build_destinations({{si, sf}, {di, df}, iter}, {a, b}, acc) when si == a and sf < b,
    do: get_destinations(iter, {sf + 1, b}, [{di, df} | acc])

  # a ------- b
  #    si -- sf
  defp build_destinations({{si, sf}, {di, df}, _}, {a, b}, acc) when si > a and sf == b,
    do: [{a, si - 1}, {di, df} | acc]

  # a ------------ b
  #    si -- sf
  defp build_destinations({{si, sf}, {di, df}, iter}, {a, b}, acc) when si > a and sf < b,
    do: get_destinations(iter, {sf + 1, b}, [{a, si - 1}, {di, df} | acc])

  #      a ----- b
  # si ---- sf
  defp build_destinations({{si, sf}, {di, df}, iter}, {a, b}, acc) when si < a and sf < b,
    do: get_destinations(iter, {sf + 1, b}, [{a - si + di, df} | acc])

  # a ----- b
  #     si ---- sf
  defp build_destinations({{si, sf}, {_, _}, _}, {a, b}, acc) when si > a and sf > b,
    do: [{a, b} | acc]
end
