defmodule Pompey.Route do
  @attrs [:name, :description, :method, :url, :path]
  @derive Jason.Encoder
  defstruct @attrs

  @methods ["GET"]

  def method_valid?(route) do
    Enum.member? @methods, route.method
  end

  def from_params(params) do
    filtered_params = params |> filter_params
    errors = filtered_params |> validate
    if Enum.empty?(errors) do
      {:ok, struct(__MODULE__, filtered_params)}
    else
      {:error, errors}
    end
  end

  def from_attrs(params) do
    struct __MODULE__, filter_params(params)
  end

  def filter_params(params) do
    Enum.reduce(@attrs, %{}, fn (item, memo) ->
      case Map.fetch(params, Atom.to_string(item)) do
        {:ok, value} -> Map.put(memo, item, value)
        :error -> memo
      end
    end)
  end

  def validate(attrs) do
    errors = %{}
    errors = validate_presence(errors, attrs, "name")
    errors = validate_presence(errors, attrs, "url")
    errors = validate_presence(errors, attrs, "path")
    if !Enum.member?(@methods, attrs["method"]) do
      Map.put(errors, "method", "is not one of #{@methods}")
    else
      errors
    end
  end

  def validate_presence(errors, attrs, attr_name) do
    unless Map.has_key?(attrs, attr_name) do
      Map.put(errors, attr_name, "is required")
    else
      errors
    end
  end

  def attrs do
    @attrs
  end

  def from_tuple({name, method, url, path, description}) do
    %__MODULE__{name: name, method: method, url: url, path: path, description: description}
  end
end
