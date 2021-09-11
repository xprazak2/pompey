use Mix.Config

config :pompey, port: 80
config :pompey, storage_path: System.get_env("storage_path", "./route_list.json")
