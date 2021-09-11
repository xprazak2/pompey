defmodule Pompey.Schemas do
  # alias OpenApiSpex.Schema
  # require OpenApiSpex

  # defmodule Route do
  #   OpenApiSpex.schema(%{
  #     title: "Route",
  #     description: "A route to be proxied",
  #     type: :object,
  #     properties: %{
  #       name: %Schema{type: :string, description: "Route name"},
  #       description: %Schema{type: :string, description: "Route description"},
  #       method: %Schema{type: :string, description: "Method to use for a request"},
  #       url: %Schema{type: :string, description: "Route URL"},
  #       path: %Schema{type: :string, description: "Route path"}
  #     },
  #     required: [:name, :method, :url, :path],
  #     example: %{
  #       "name" => "foo",
  #       "description" => "Proxy /foo to github.com",
  #       "method" => "GET",
  #       "url" => "http://github.com",
  #       "path" => "/foo"
  #     }
  #   })
  # end

  # defmodule RoutesResponse do
  #   OpenApiSpex.schema(%{
  #     title: "RoutesResponse",
  #     description: "Response schema for routes list",
  #     type: :object,
  #     properties: %{
  #       result: %Schema{type: :array, description: "Routes details", items: Route}
  #     },
  #     example: %{
  #       "result" => [
  #         %{
  #           "name" => "foo",
  #           "description" => "Proxy /foo to github.com",
  #           "method" => "GET",
  #           "url" => "http://github.com",
  #           "path" => "/foo"
  #         },
  #         %{
  #           "name" => "bar",
  #           "description" => "Proxy /bar to google.com",
  #           "method" => "GET",
  #           "url" => "http://google.com",
  #           "path" => "/bar"
  #         }
  #       ]
  #     }
  #   })
  # end
end