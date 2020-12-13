defmodule Pompey.Route do
  @attrs [:name, :description, :method, :url, :path]
  @derive Jason.Encoder
  defstruct @attrs

  @methods ["GET", "PUT", "POST", "DELETE"]

  def method_valid?(route) do
    Enum.member? @methods, route.method
  end

  def from_params(params) do
    # validations
    filtered_params = Enum.reduce(@attrs, %{}, fn (item, memo) ->
      case Map.fetch(params, Atom.to_string(item)) do
        {:ok, value} -> Map.put(memo, item, value)
        :error -> memo
      end
    end)

    struct __MODULE__, filtered_params
  end

  def attrs do
    @attrs
  end

  def from_tuple({name, method, url, path, description}) do
    %__MODULE__{name: name, method: method, url: url, path: path, description: description}
  end
end
