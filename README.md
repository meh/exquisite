Exquisite match_specs for Elixir
================================
Ever had to write a complex match_spec and ended up with a bunch of
unintelligible code you hoped you would never have to work on ever again?

Those times are gone! Say hello to Exquisite!

What is this?
-------------
Exquisite converts a LINQ-inspired query language into match_specs at compile
time so you can use them with mnesia, ets and dets.

It supports record reflection to access record fields directly in the query and
allows complex data generation and compare.

It also has some helpers to select with matchspecs from tuples and list of
tuples.

Examples
--------

```elixir
require Exquisite

s = Exquisite.match URI.Info,
      where:  host == "google.com",
      select: path
  
r = Exquisite.run! s, [ URI.parse("http://google.com/derp"),
                        URI.parse("http://yahoo.com/herp"),
                        URI.parse("http://bing.com/durp"),
                        URI.parse("http://google.com/herp") ]

IO.inspect r # => ["/derp", "/herp"]
```

```elixir
require Exquisite

s = Exquisite.match { x, y, z },
      where:  z > 2 and y < 3,
      select: x

r = Exquisite.run! s, [ { 1, 2, 3 },
                        { 4, 5, 6 },
                        { 7, 8, 9 } ]

IO.inspect r # => [1]
```

```elixir
require Exquisite

s = Exquisite.match { uri in URI.Info, x in { a, b } },
      where:  uri.path == nil,
      select: { x.b, x.a }

r = Exquisite.run! s, [ { URI.parse("http://google.com/derp"), { 1, 2 } },
                        { URI.parse("http://yahoo.com"), { 2, 3 } },
                        { URI.parse("http://bing.com/durp"), { 4, 5 } },
                        { URI.parse("http://google.com"), { 6, 7 } } ]

IO.inspect r # => [{3, 2}, {7, 6}]
```
