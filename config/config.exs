# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :matcher,
  ecto_repos: [Matcher.Repo]

# Configures the endpoint
config :matcher, Matcher.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "JaxVlitfXRhApLjAe272XCAgIYmm61zmb8RPtW5YwrFNIrdqd4J/FbScEopoayAF",
  render_errors: [view: Matcher.ErrorView, accepts: ~w(json)],
  pubsub: [name: Matcher.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
