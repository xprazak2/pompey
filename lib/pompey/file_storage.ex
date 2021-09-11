defmodule Pompey.FileStorage do
  def load do
    case File.read(storage_path()) do
       {:ok, content} -> parse_list(content)
       {_, reason} -> {:err, "Failed to read from #{storage_path()}, reason: #{reason}"}
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
       {:ok, content} -> write_to_file(content)
       {:err, err} -> {:err, err}
    end
  end

  def write_to_file(content) do
    file_path = storage_path()
    case File.write(file_path, content) do
      :ok -> :ok
      {_, err} -> {:err, "Failed writing to #{file_path}, reason: #{err}" }
    end
  end

  defp storage_path do
    Application.get_env(:pompey, :storage_path)
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
