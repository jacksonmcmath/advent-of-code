defmodule AdventOfCode.Y2023.D07 do
  @moduledoc """
  --- Day 7: Camel Cards ---
  Puzzle Link: https://adventofcode.com/2023/day/7
  """
  @behaviour AdventOfCode.Puzzle

  @card_ranks %{
    "2" => 1,
    "3" => 2,
    "4" => 3,
    "5" => 4,
    "6" => 5,
    "7" => 6,
    "8" => 7,
    "9" => 8,
    "T" => 9,
    "J" => 10,
    "Q" => 11,
    "K" => 12,
    "A" => 13
  }

  defp input(), do: AdventOfCode.get_input!(2023, 7)

  @impl AdventOfCode.Puzzle
  def run(input \\ input()), do: {part_1(input), part_2(input)}

  @impl AdventOfCode.Puzzle
  def part_1(input) do
    input
    |> parse_input()
    |> calculate_winnings(@card_ranks)
  end

  @impl AdventOfCode.Puzzle
  def part_2(input) do
    input
    |> parse_input()
    |> Enum.map(fn {rank, hand, bid} -> {jokered_rank(rank, hand), hand, bid} end)
    |> calculate_winnings(%{@card_ranks | "J" => 0})
  end

  defp parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      [hand, bid] = String.split(line, " ", trim: true)
      hand = String.graphemes(hand)
      {rank(hand), hand, bid |> String.to_integer()}
    end)
  end

  defp calculate_winnings(hands, mapping) do
    hands
    |> Enum.group_by(&elem(&1, 0))
    |> Enum.sort_by(fn {rank, _} -> rank end)
    |> Enum.flat_map(fn {_, hands} ->
      hands |> Enum.sort(fn {_, h1, _}, {_, h2, _} -> smaller?(h1, h2, mapping) end)
    end)
    |> Enum.with_index(1)
    |> Enum.reduce(0, fn {{_, _, bid}, rank}, acc -> acc + bid * rank end)
  end

  defp rank(hand) do
    case hand
         |> frequency_map()
         |> Map.values()
         |> Enum.sort() do
      [1, 1, 1, 1, 1] -> 1
      [1, 1, 1, 2] -> 2
      [1, 2, 2] -> 3
      [1, 1, 3] -> 4
      [2, 3] -> 5
      [1, 4] -> 6
      [5] -> 7
    end
  end

  defp jokered_rank(rank, hand) when is_list(hand) do
    jokered_rank(rank, frequency_map(hand)["J"])
  end

  defp jokered_rank(rank, nil), do: rank
  defp jokered_rank(1, _jokers), do: 2
  defp jokered_rank(2, _jokers), do: 4
  defp jokered_rank(3, 1), do: 5
  defp jokered_rank(3, 2), do: 6
  defp jokered_rank(4, _jokers), do: 6
  defp jokered_rank(5, _jokers), do: 7
  defp jokered_rank(6, _jokers), do: 7
  defp jokered_rank(7, _jokers), do: 7

  defp frequency_map(hand),
    do: hand |> Enum.group_by(& &1) |> Map.new(fn {a, b} -> {a, length(b)} end)

  defp smaller?([a | rest_1], [b | rest_2], mapping) do
    cond do
      mapping[a] > mapping[b] -> false
      mapping[a] < mapping[b] -> true
      true -> smaller?(rest_1, rest_2, mapping)
    end
  end
end
