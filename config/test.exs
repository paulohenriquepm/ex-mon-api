import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :ex_mon_api, ExMonApi.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "ex_mon_api_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :ex_mon_api, ExMonApiWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "iauoaeZlBHovOGmKdQkaSNiGg5RD2MvAKPJ8BD30aJe2Sn8E2iPM8nNDjZSQ+rOX",
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
