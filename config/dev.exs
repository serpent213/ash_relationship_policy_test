import Config

config :ash_test, AshTest.Repo,
  username: "dev",
  password: "dev",
  hostname: "localhost",
  port: 5777,
  database: "ash_dev",
  show_sensitive_data_on_connection_error: true,
  pool_size: 10
