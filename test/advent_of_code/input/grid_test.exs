defmodule AdventOfCode.Input.GridTest do
  @moduledoc false
  use ExUnit.Case, async: true

  alias AdventOfCode.Input.Grid, as: Target

  describe "from_list/1" do
    test "should return map of coordinate tuples to values" do
      expected = %{{0, 0} => 1, {0, 1} => 2, {1, 0} => 3, {1, 1} => 4}
      actual = Target.from_list([[1, 2], [3, 4]])

      assert actual == expected
    end

    test "should return empty map when list is empty" do
      expected = %{}
      actual = Target.from_list([])

      assert actual == expected
    end
  end

  describe "surrounding_8/1" do
    test "should return correct coordinates" do
      expected = [{1, 0}, {-1, 0}, {0, 1}, {0, -1}, {1, 1}, {-1, -1}, {1, -1}, {-1, 1}]
      actual = Target.surrounding_8({0, 0})

      assert actual == expected
    end
  end

  describe "surrounding_4/1" do
    test "should return correct coordinates" do
      expected = [{1, 0}, {-1, 0}, {0, 1}, {0, -1}]
      actual = Target.surrounding_4({0, 0})

      assert actual == expected
    end
  end
end
