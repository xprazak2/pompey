defmodule Pompey.Routes.Common do
  def to_resp(data) do
    %{ result: data } |> Jason.encode!
  end

  def to_error(data) do
    %{ error: data } |> Jason.encode!
  end
end