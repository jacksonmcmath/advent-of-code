defmodule AdventOfCode.Y2023.D05Test do
  @moduledoc false
  use ExUnit.Case, async: true

  alias AdventOfCode.Y2023.D05, as: Solution

  @moduletag year: 2023, day: 5

  test "Year 2023, Day 05, part_1/1" do
    input = """
    seeds: 79 14 55 13

    seed-to-soil map:
    50 98 2
    52 50 48

    soil-to-fertilizer map:
    0 15 37
    37 52 2
    39 0 15

    fertilizer-to-water map:
    49 53 8
    0 11 42
    42 0 7
    57 7 4

    water-to-light map:
    88 18 7
    18 25 70

    light-to-temperature map:
    45 77 23
    81 45 19
    68 64 13

    temperature-to-humidity map:
    0 69 1
    1 0 69

    humidity-to-location map:
    60 56 37
    56 93 4
    """

    assert Solution.part_1(input) == 35
  end

  test "Year 2023, Day 05, part_2/1" do
    input = """
    seeds: 79 14 55 13

    seed-to-soil map:
    50 98 2
    52 50 48

    soil-to-fertilizer map:
    0 15 37
    37 52 2
    39 0 15

    fertilizer-to-water map:
    49 53 8
    0 11 42
    42 0 7
    57 7 4

    water-to-light map:
    88 18 7
    18 25 70

    light-to-temperature map:
    45 77 23
    81 45 19
    68 64 13

    temperature-to-humidity map:
    0 69 1
    1 0 69

    humidity-to-location map:
    60 56 37
    56 93 4
    """

    assert Solution.part_2(input) == 46
  end

  test "Year 2023, Day 05, run/0" do
    assert Solution.run() == {173_706_076, 11_611_182}
  end
end
