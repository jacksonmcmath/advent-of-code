defmodule AdventOfCode.Y2023.D04Test do
  @moduledoc false
  use ExUnit.Case, async: true

  alias AdventOfCode.Y2023.D04, as: Solution

  @moduletag year: 2023, day: 4

  test "Year 2023, Day 04, part_1/1" do
    input = """
    Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
    Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19
    Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1
    Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83
    Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36
    Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11
    """

    assert Solution.part_1(input) == 13
  end

  test "Year 2023, Day 04, part_2/1" do
    input = """
    Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
    Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19
    Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1
    Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83
    Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36
    Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11
    """

    assert Solution.part_2(input) == 30
  end

  test "Year 2023, Day 04, run/0" do
    assert Solution.run() == {27_454, 6_857_330}
  end
end
