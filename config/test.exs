use Mix.Config

config :pompey, port: 4002
config :pompey, storage_path: System.get_env("STORAGE_PATH", "./test/route_list_fixture.json")
