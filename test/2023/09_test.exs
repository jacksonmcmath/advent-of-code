defmodule AdventOfCode.Y2023.D09Test do
  @moduledoc false
  use ExUnit.Case, async: true

  alias AdventOfCode.Y2023.D09, as: Solution

  @moduletag year: 2023, day: 9

  test "Year 2023, Day 09, part_1/1" do
    input = """
    0 3 6 9 12 15
    1 3 6 10 15 21
    10 13 16 21 30 45
    """

    assert Solution.part_1(input) == 114
  end

  test "Year 2023, Day 09, part_2/1" do
    input = """
    0 3 6 9 12 15
    1 3 6 10 15 21
    10 13 16 21 30 45
    """

    assert Solution.part_2(input) == 2
  end

  test "Year 2023, Day 09, run/0" do
    assert Solution.run() == {1_995_001_648, 988}
  end
end
