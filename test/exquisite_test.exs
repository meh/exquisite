Code.require_file "test_helper.exs", __DIR__

defmodule ExquisiteTest do
  use ExUnit.Case
  require Exquisite

  test "tuples work" do
    s = Exquisite.match { a, b },
      where:  a == { 1, 2 },
      select: b

    assert Exquisite.run!(s, { { 1, 2 }, 3 }) == 3
  end

  test "works with tuples inside tuples" do
    s = Exquisite.match { { a, b }, c },
      where:  a == b,
      select: c

    assert Exquisite.run!(s, { { 1, 1 }, 2 }) == 2
  end

  test "works with tuples inside tuples as values" do
    from = {{2013,1,1},{1,1,1}}
    to   = {{2013,2,2},{1,1,1}}

    s = Exquisite.match { a, b },
      where:  a >= from and b <= to,
      select: 2

    assert Exquisite.run!(s, { from, to }) == 2
  end


  test "Alternative &&&, ||| usage." do
    from = {{2013,1,1},{1,1,1}}
    to   = {{2013,2,2},{1,1,1}}
    s = Exquisite.match { a, b },
                        where:  a >= from &&& b <= to ||| b >= to &&& a <= from,
                        select: 2
    assert Exquisite.run!(s, { from, to }) == 2
  end


  test "and, and or work on elixir 1.6 and later." do
    from = {{2013,1,1},{1,1,1}}
    to   = {{2013,2,2},{1,1,1}}
    s = Exquisite.match { a, b },
                        where:  a >= from and b <= to or b >= to and a <= from,
                        select: 2
    assert Exquisite.run!(s, { from, to }) == 2
  end

  test "works with named tuple" do
    s = Exquisite.match foo in { a, b },
      where:  foo.a == { 1, 2 },
      select: foo.b

    assert Exquisite.run!(s, { { 1, 2 }, 3 }) == 3
  end

  test "works with named tuple inside tuple" do
    s = Exquisite.match foo in { a in { a, b }, b },
      where:  foo.a.a == foo.a.b,
      select: foo.b

    assert Exquisite.run!(s, { { 1, 1 }, 3 }) == 3
  end

  test "works with a value" do
    s = Exquisite.match { a, 2 },
      where: a == 3


    assert Exquisite.run!(s, { 3, 2 })
    refute Exquisite.run!(s, { 3, 3 })
    refute Exquisite.run!(s, { 2, 2 })
  end

  test "works elem specification" do
    s = Exquisite.match foo in { a, b },
      where:  elem(foo.a, 0) == 1,
      select: foo.b

    assert Exquisite.run!(s, { { 1, 2 }, 3 }) == 3
  end
end
