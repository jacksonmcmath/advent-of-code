defmodule AdventOfCode.Y2023.D07Test do
  @moduledoc false
  use ExUnit.Case, async: true

  alias AdventOfCode.Y2023.D07, as: Solution

  @moduletag year: 2023, day: 7

  test "Year 2023, Day 07, part_1/1" do
    input = """
    32T3K 765
    T55J5 684
    KK677 28
    KTJJT 220
    QQQJA 483
    """

    assert Solution.part_1(input) == 6440
  end

  test "Year 2023, Day 07, part_2/1" do
    input = """
    32T3K 765
    T55J5 684
    KK677 28
    KTJJT 220
    QQQJA 483
    """

    assert Solution.part_2(input) == 5905
  end

  test "Year 2023, Day 07, run/0" do
    assert Solution.run() == {250_453_939, 248_652_697}
  end
end
