# Pompey

**Small, simple and stupid proxy that forwards your requests**

Uses macros to generate dynamic routes, so recompile is needed after a new route is added.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `pompey` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:pompey, "~> 0.1.0"}
  ]
end
```

For development:

```
mix deps.get
iex -S mix
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/pompey](https://hexdocs.pm/pompey).

