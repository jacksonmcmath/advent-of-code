defmodule AdventOfCode.Y2024.D04Test do
  @moduledoc false
  use ExUnit.Case, async: true

  alias AdventOfCode.Y2024.D04, as: Solution

  @moduletag year: 2024, day: 4

  test "Year 2024, Day 04, part_1/1" do
    input = """
    MMMSXXMASM
    MSAMXMSMSA
    AMXSXMAAMM
    MSAMASMSMX
    XMASAMXAMM
    XXAMMXXAMA
    SMSMSASXSS
    SAXAMASAAA
    MAMMMXMMMM
    MXMXAXMASX
    """

    assert Solution.part_1(input) == 18
  end

  test "Year 2024, Day 04, part_2/1" do
    input = """
    MMMSXXMASM
    MSAMXMSMSA
    AMXSXMAAMM
    MSAMASMSMX
    XMASAMXAMM
    XXAMMXXAMA
    SMSMSASXSS
    SAXAMASAAA
    MAMMMXMMMM
    MXMXAXMASX
    """

    assert Solution.part_2(input) == 9
  end

  test "Year 2024, Day 04, run/0" do
    assert Solution.run() == {2524, 1873}
  end
end
