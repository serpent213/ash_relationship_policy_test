import Config

config :logger, level: :warning
config :ash, disable_async?: true

config :ash_test, AshTest.Repo,
  username: "dev",
  password: "dev",
  hostname: "localhost",
  port: 5777,
  database: "ash_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10
