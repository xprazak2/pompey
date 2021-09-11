defmodule Pompey.Schemas do
  alias OpenApiSpex.Schema
  require OpenApiSpex

  defmodule Route do
    OpenApiSpex.schema(%{
      title: "Route",
      description: "A route to be proxied",
      type: :object,
      properties: %{
        name: %Schema{type: :string, description: "Route name"},
        description: %Schema{type: :string, description: "Route description"},
        method: %Schema{type: :string, description: "Method to use for a request"},
        url: %Schema{type: :string, description: "Route URL"},
        path: %Schema{type: :string, description: "Route path"}
      },
      required: [:name, :method, :url, :path],
      example: %{
        "name" => "foo",
        "description" => "Proxy /foo to github.com",
        "method" => "GET",
        "url" => "http://github.com",
        "path" => "/foo"
      }
    })
  end

  defmodule RoutesResponse do
    OpenApiSpex.schema(%{
      title: "RoutesResponse",
      description: "Response schema for routes list",
      type: :object,
      properties: %{
        result: %Schema{type: :array, description: "Routes details", items: Route}
      },
      example: %{
        "result" => [
          %{
            "name" => "foo",
            "description" => "Proxy /foo to github.com",
            "method" => "GET",
            "url" => "http://github.com",
            "path" => "/foo"
          },
          %{
            "name" => "bar",
            "description" => "Proxy /bar to google.com",
            "method" => "GET",
            "url" => "http://google.com",
            "path" => "/bar"
          }
        ]
      }
    })
  end

  defmodule RouteResponse do
    OpenApiSpex.schema(%{
      title: "RouteResponse",
      description: "Response schema for a route",
      type: :object,
      properties: %{
        result: Route
      },
      example: %{
        "result" => %{
          "name" => "foo",
          "description" => "Proxy /foo to github.com",
          "method" => "GET",
          "url" => "http://github.com",
          "path" => "/foo"
        }
      }
    })
  end

  defmodule RouteRequest do
    OpenApiSpex.schema(%{
      title: "RouteRequest",
      description: "POST body for creating a route",
      type: :object,
      properties: %{
        route: Route
      },
      required: [:route],
      example: %{
        "route" => %{
          "name" => "foo",
          "description" => "Proxy /foo to github.com",
          "method" => "GET",
          "url" => "http://github.com",
          "path" => "/foo"
        }
      }
    })
  end

  defmodule RouteCreateError do
    OpenApiSpex.schema(%{
      title: "RouteResponse",
      description: "Response schema for a route",
      type: :object,
      properties: %{
        error: %Schema{type: :string, description: "Error message"}
      },
      example: %{
        "error" => "Error creating a route"
      }
    })
  end
end