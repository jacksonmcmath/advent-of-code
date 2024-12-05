defmodule AdventOfCode.Y2023.D08Test do
  @moduledoc false
  use ExUnit.Case, async: true

  alias AdventOfCode.Y2023.D08, as: Solution

  @moduletag year: 2023, day: 8

  test "Year 2023, Day 08, part_1/1" do
    input = """
    LLR

    AAA = (BBB, BBB)
    BBB = (AAA, ZZZ)
    ZZZ = (ZZZ, ZZZ)
    """

    assert Solution.part_1(input) == 6
  end

  test "Year 2023, Day 08, part_2/1" do
    input = """
    LR

    11A = (11B, XXX)
    11B = (XXX, 11Z)
    11Z = (11B, XXX)
    22A = (22B, XXX)
    22B = (22C, 22C)
    22C = (22Z, 22Z)
    22Z = (22B, 22B)
    XXX = (XXX, XXX)
    """

    assert Solution.part_2(input) == 6
  end

  test "Year 2023, Day 08, run/0" do
    assert Solution.run() == {11_309, 13_740_108_158_591}
  end
end
