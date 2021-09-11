defmodule Pompey.Storage do
  use GenServer

  @impl true
  def init(_) do
    # should I load dangerously and let it crash?
    state = Pompey.FileStorage.safe_load |>
      Enum.reduce(%{}, fn item, memo -> Map.put(memo, item.name, item) end)
    {:ok, state}
  end

  @impl true
  def handle_call({:index}, _, state) do
    {:reply, state, state}
  end

  @impl true
  def handle_call({:create, route}, _, state) do
    new_state = Map.put(state, route.name, route)

    case new_state |> Map.values |> Pompey.FileStorage.save do
      :ok -> {:reply, {:ok, route}, new_state}
      {_, err} -> {:reply, {:error, err }, state}
    end
  end

  @impl true
  def handle_call({:delete, route_name}, _, state) do
    route = case Map.fetch(state, route_name) do
       {:ok, item} -> item
       :error -> nil
    end
    new_state = Map.delete(state, route_name)
    {:reply, route, new_state}
  end

  def start_link(opts) do
    GenServer.start(__MODULE__, opts, name: opts[:name])
  end

  def index do
    GenServer.call(__MODULE__, {:index})
  end

  def create(route) do
    GenServer.call(__MODULE__, {:create, route})
  end

  def delete(route_name) do
    GenServer.call(__MODULE__, {:delete, route_name})
  end
end
