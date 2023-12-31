defmodule AdventOfCode.Y2023.D06Test do
  @moduledoc false
  use ExUnit.Case

  alias AdventOfCode.Y2023.D06, as: Solution

  @moduletag year: 2023, day: 6

  test "Year 2023, Day 06, part_1/1" do
    input = """
    Time:      7  15   30
    Distance:  9  40  200
    """

    assert Solution.part_1(input) == 288
  end

  test "Year 2023, Day 06, part_2/1" do
    input = """
    Time:      7  15   30
    Distance:  9  40  200
    """

    assert Solution.part_2(input) == 71_503
  end

  test "Year 2023, Day 06, run/0" do
    assert Solution.run() == {1_731_600, 40_087_680}
  end
end
