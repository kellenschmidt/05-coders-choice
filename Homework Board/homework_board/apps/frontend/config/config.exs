# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :frontend,
  namespace: Frontend

# Configures the endpoint
config :frontend, FrontendWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "ZS18Qdp9kZtzeVV46hD1mhj4WyFDgyxmNRaCe2OFSJSYoVzUicvHWopNt/3t2aYB",
  render_errors: [view: FrontendWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Frontend.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
