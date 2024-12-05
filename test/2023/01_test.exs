defmodule AdventOfCode.Y2023.D01Test do
  @moduledoc false
  use ExUnit.Case, async: true

  alias AdventOfCode.Y2023.D01, as: Solution

  @moduletag year: 2023, day: 1

  test "Year 2023, Day 01, part_1/1" do
    input = """
    1abc2
    pqr3stu8vwx
    a1b2c3d4e5f
    treb7uchet
    """

    assert Solution.part_1(input) == 142
  end

  test "Year 2023, Day 01, part_2/1" do
    input = """
    two1nine
    eightwothree
    abcone2threexyz
    xtwone3four
    4nineeightseven2
    zoneight234
    7pqrstsixteen
    """

    assert Solution.part_2(input) == 281
  end

  test "Year 2023, Day 01, run/0" do
    assert Solution.run() == {54_601, 54_078}
  end
end
