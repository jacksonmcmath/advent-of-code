defmodule AdventOfCode.Y2024.D02Test do
  @moduledoc false
  use ExUnit.Case, async: true

  alias AdventOfCode.Y2024.D02, as: Solution

  @moduletag year: 2024, day: 2

  test "Year 2024, Day 02, part_1/1" do
    input = """
    7 6 4 2 1
    1 2 7 8 9
    9 7 6 2 1
    1 3 2 4 5
    8 6 4 4 1
    1 3 6 7 9
    """

    assert Solution.part_1(input) == 2
  end

  test "Year 2024, Day 02, part_2/1" do
    input = """
    7 6 4 2 1
    1 2 7 8 9
    9 7 6 2 1
    1 3 2 4 5
    8 6 4 4 1
    1 3 6 7 9
    """

    assert Solution.part_2(input) == 4
  end

  test "Year 2024, Day 02, run/0" do
    assert Solution.run() == {411, 465}
  end
end
