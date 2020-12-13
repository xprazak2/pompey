defmodule Dynamic do
  defmacro define do
    routes = [%{ :name => "foo", :method => "get", :path => "/foo" }]

    routes_ast = routes |> Enum.map(&Dynamic.build_ast/1)

    quote do
      unquote_splicing routes_ast
    end
  end

  def build_ast(route) do
    quote do
      def foo(unquote(route.path), via: unquote(String.to_atom route.method)) do
        Dynamic.forward(unquote(route))
      end
      # match(unquote(route.path), via: unquote(String.to_atom route.method)) do
      #   Dynamic.forward(var!(conn), unquote(route))
      # end
    end
  end

  def forward(route) do
    nil
  end
end

defmodule Static do
  import Dynamic

  def load do
    Dynamic.define
  end
end
