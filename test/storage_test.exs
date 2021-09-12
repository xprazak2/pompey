defmodule Pompey.StorageTest do
  use ExUnit.Case, async: false

  # Mock does not allow async tests and I am told that is bad,
  # though I am more concerned about mocking the core modules.
  # It seems like the most common approach is to inject the modules
  # via Application.get_env
  import Mock

  setup do
    start_supervised!(Pompey.Storage)
    :ok
  end

  test "should list all routes" do
    index = Pompey.Storage.index
    assert index["foo"]
    assert index["bar"]
    assert 2 == Enum.count(index)
  end

  test "should create a new route" do
    name = 'test'
    route = %Pompey.Route{
      name: name,
      description: 'test',
      method: 'GET',
      url: 'http://test.com',
      path: '/test'
    }

    assert 2 == Enum.count(Pompey.Storage.index)

    with_mock File, [write: fn(_path, _content) -> :ok end] do
      {:ok, route} = Pompey.Storage.create(route)
      assert route.name == name
    end

    assert 3 == Enum.count(Pompey.Storage.index)
  end

  test "should not create a new route" do
    name = 'test'
    route = %Pompey.Route{
      name: name,
      description: 'test',
      method: 'GET',
      url: 'http://test.com',
      path: '/test'
    }

    assert 2 == Enum.count(Pompey.Storage.index)

    with_mock File, [write: fn(_path, _content) -> {:errno, :enoent} end] do
      {:error, err} = Pompey.Storage.create(route)
      assert err == "Failed writing to ./test/route_list_fixture.json, reason: enoent"
    end

    assert 2 == Enum.count(Pompey.Storage.index)
  end
end
