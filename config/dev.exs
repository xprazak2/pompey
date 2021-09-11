use Mix.Config

config :pompey, port: 4001
config :pompey, storage_path: System.get_env("STORAGE_PATH", "./route_list_dev.json")
