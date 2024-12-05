defmodule AdventOfCode.Y2024.D03Test do
  @moduledoc false
  use ExUnit.Case, async: true

  alias AdventOfCode.Y2024.D03, as: Solution

  @moduletag year: 2024, day: 3

  test "Year 2024, Day 03, part_1/1" do
    input = "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))"

    assert Solution.part_1(input) == 161
  end

  test "Year 2024, Day 03, part_2/1" do
    input = "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))"

    assert Solution.part_2(input) == 48
  end

  test "Year 2024, Day 03, run/0" do
    assert Solution.run() == {187_833_789, 94_455_185}
  end
end
