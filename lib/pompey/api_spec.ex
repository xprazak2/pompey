defmodule Pompey.ApiSpec do
  alias OpenApiSpex.{Info, OpenApi}
  @behaviour OpenApi

  @impl OpenApi
  def spec do
    %OpenApi{
      info: %Info{
        title: "Pompey",
        version: "0.1.0"
      },
      paths: %{
        "/pompey" => OpenApiSpex.PathItem.from_routes([
          %{verb: :get, plug: Pompey.Routes.Index, opts: []},
          %{verb: :post, plug: Pompey.Routes.Create, opts: []}
        ]),
      }
    } |> OpenApiSpex.resolve_schema_modules()
  end
end
