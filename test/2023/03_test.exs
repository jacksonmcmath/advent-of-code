defmodule AdventOfCode.Y2023.D03Test do
  @moduledoc false
  use ExUnit.Case, async: true

  alias AdventOfCode.Y2023.D03, as: Solution

  @moduletag year: 2023, day: 3

  test "Year 2023, Day 03, part_1/1" do
    input = """
    467..114..
    ...*......
    ..35..633.
    ......#...
    617*......
    .....+.58.
    ..592.....
    ......755.
    ...$.*....
    .664.598..
    """

    assert Solution.part_1(input) == 4361
  end

  test "Year 2023, Day 03, part_2/1" do
    input = """
    467..114..
    ...*......
    ..35..633.
    ......#...
    617*......
    .....+.58.
    ..592.....
    ......755.
    ...$.*....
    .664.598..
    """

    assert Solution.part_2(input) == 467_835
  end

  test "Year 2023, Day 03, run/0" do
    assert Solution.run() == {536_576, 75_741_499}
  end
end
