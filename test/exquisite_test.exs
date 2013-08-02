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

  defrecord Foo, [:a, :b] do
    def test do
      Exquisite.match __MODULE__,
        where: b == 2,
        select: a
    end
  end

  test "works with __MODULE__" do
    s = Foo.test
    assert Exquisite.run!(s, Foo[a: 2, b: 3]) == false
    assert Exquisite.run!(s, Foo[a: 3, b: 2]) == 3
  end

  defmodule Helpers do
    defmacro get_by_key(module, key, value) do
      quote do
        s = Exquisite.match unquote(module),
          where: unquote(key) == unquote(value)
      end
    end
  end

  defrecord Bar, [:id, :foo] do
    require Helpers

    defmacro get_by_key(key, value) do
      quote do
        Helpers.get_by_key(unquote(__MODULE__),
          unquote(key), unquote(value))
      end
    end
  end

  test "runs properly with macros" do
    require Bar
    require Helpers

    assert Exquisite.run(Bar.get_by_key(foo, 3), [Bar[id: 2, foo: 3], Bar[id: 3, foo: 4]]) ==
      [Bar[id: 2, foo: 3]]
  end
end
