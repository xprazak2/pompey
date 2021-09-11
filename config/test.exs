use Mix.Config

config :pompey, port: 4002
config :pompey, storage_path: System.get_env("storage_path", "./route_list_test.json")