defmodule Pompey.FileStorage do
  @file_db "./route_list.json"

  def load do
    case File.read(@file_db) do
       {:ok, content} -> parse_list(content)
       err -> err
    end
  end

  def safe_load do
    case load() do
      {:ok, list} -> list
      _err -> []
    end
  end

  def save(routes) do
    case routes |> encode_list do
       {:ok, content} -> File.write(@file_db, content)
       {:err, err} -> {:err, err}
    end
  end

  defp parse_list(content) do
    case content |> Jason.decode do
      {:ok, result} -> {:ok, Enum.map(result, &Pompey.Route.from_attrs/1)}
      err -> err
    end
  end

  defp encode_list(routes) do
    routes |> Jason.encode
  end
end
