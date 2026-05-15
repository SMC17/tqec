defmodule Tqex.CoreTest do
  use ExUnit.Case
  doctest Tqex.Core

  test "shifts 3D position correctly via Zig NIF" do
    # Initial position: (10, 20, 30)
    # Shift in direction X (0) by 5
    assert {15, 20, 30} == Tqex.Core.shift_in_direction(10, 20, 30, 0, 5)

    # Shift in direction Y (1) by -10
    assert {10, 10, 30} == Tqex.Core.shift_in_direction(10, 20, 30, 1, -10)

    # Shift in direction Z (2) by 100
    assert {10, 20, 130} == Tqex.Core.shift_in_direction(10, 20, 30, 2, 100)
  end
end
