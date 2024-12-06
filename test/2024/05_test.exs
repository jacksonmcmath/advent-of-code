defmodule AdventOfCode.Y2024.D05Test do
  @moduledoc false
  use ExUnit.Case, async: true

  alias AdventOfCode.Y2024.D05, as: Solution

  @moduletag year: 2024, day: 5

  test "Year 2024, Day 05, part_1/1" do
    input = """
    47|53
    97|13
    97|61
    97|47
    75|29
    61|13
    75|53
    29|13
    97|29
    53|29
    61|53
    97|53
    61|29
    47|13
    75|47
    97|75
    47|61
    75|61
    47|29
    75|13
    53|13

    75,47,61,53,29
    97,61,53,29,13
    75,29,13
    75,97,47,61,53
    61,13,29
    97,13,75,29,47
    """

    assert Solution.part_1(input) == 143
  end

  test "Year 2024, Day 05, part_2/1" do
    input = """
    47|53
    97|13
    97|61
    97|47
    75|29
    61|13
    75|53
    29|13
    97|29
    53|29
    61|53
    97|53
    61|29
    47|13
    75|47
    97|75
    47|61
    75|61
    47|29
    75|13
    53|13

    75,47,61,53,29
    97,61,53,29,13
    75,29,13
    75,97,47,61,53
    61,13,29
    97,13,75,29,47
    """

    assert Solution.part_2(input) == 123
  end

  test "Year 2024, Day 05, run/0" do
    assert Solution.run() == {5991, 5479}
  end
end
