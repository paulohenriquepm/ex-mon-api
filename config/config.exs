# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :ex_mon_api,
  ecto_repos: [ExMonApi.Repo]

# Configures the endpoint
config :ex_mon_api, ExMonApiWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: ExMonApiWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: ExMonApi.PubSub,
  live_view: [signing_salt: "oqEDpCfG"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :ex_mon_api, ExMonApiWeb.Auth.Guardian,
  issuer: "ex_mon_api",
  secret_key: "4SLri6RnhFUXrWi0q9CLDKIqP3YJUqkJUrYwCuSakrsiaShNGl+p2bP0HCsGvMtj"

config :ex_mon_api, ExMonApiWeb.Auth.Pipeline,
  module: ExMonApiWeb.Auth.Guardian,
  error_handler: ExMonApiWeb.Auth.ErrorHandler

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
