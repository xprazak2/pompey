defmodule PompeyTest do
  use ExUnit.Case
  doctest Pompey

  test "greets the world" do
    assert Pompey.hello() == :world
  end
end
