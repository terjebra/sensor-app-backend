# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :sensor_api,
  ecto_repos: [SensorApi.Repo]

# Configures the endpoint
config :sensor_api, SensorApi.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "MRQkI8u2/2TD9NSTnV2/XI8q2FVfkPM9Tad+/pXhNcEpH2gmvwFC598Gb8Cvs/+t",
  render_errors: [view: SensorApi.ErrorView, accepts: ~w(html json)],
  pubsub: [name: SensorApi.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
