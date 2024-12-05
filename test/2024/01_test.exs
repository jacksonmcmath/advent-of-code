defmodule AdventOfCode.Y2024.D01Test do
  @moduledoc false
  use ExUnit.Case, async: true

  alias AdventOfCode.Y2024.D01, as: Solution

  @moduletag year: 2024, day: 1

  test "Year 2024, Day 01, part_1/1" do
    input = """
    3   4
    4   3
    2   5
    1   3
    3   9
    3   3
    """

    assert Solution.part_1(input) == 11
  end

  test "Year 2024, Day 01, part_2/1" do
    input = """
    3   4
    4   3
    2   5
    1   3
    3   9
    3   3
    """

    assert Solution.part_2(input) == 31
  end

  test "Year 2024, Day 01, run/0" do
    assert Solution.run() == {1_651_298, 21_306_195}
  end
end
