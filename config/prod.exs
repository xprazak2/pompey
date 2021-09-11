use Mix.Config

config :pompey, port: 80
config :pompey, storage_path: System.get_env("STORAGE_PATH", "./examples/route_list.json")
