Code.require_file "../test_helper.exs", __FILE__

defmodule ExquisiteTest do
  use ExUnit.Case
  require Exquisite

  test "tuples work" do
    s = Exquisite.match { a, b },
      where:  a == { 1, 2 },
      select: b

    assert Exquisite.run!(s, { { 1, 2 }, 3 }) == 3
  end

  test "tuples inside tuples work" do
    from = {{2013,1,1},{1,1,1}}
    to   = {{2013,2,2},{1,1,1}}

    s = Exquisite.match { a, b },
      where:  a >= from and b <= to,
      select: 2

    assert Exquisite.run!(s, { from, to }) == 2
  end
end
