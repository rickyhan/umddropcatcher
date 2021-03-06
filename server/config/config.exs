# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :server,
  mailgun_domain: System.get_env("MAILGUN_DOMAIN"),
  mailgun_key: System.get_env("MAILGUN_KEY"),
  ecto_repos: [Server.Repo]

# Configures the endpoint
config :server, Server.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "2Uv+6l1Hw/JkBthq1JePMrvHRhLnR2WtT1Y1g+9xV0/9Lg/VZfqsN2gl7tkL/Kdt",
  render_errors: [view: Server.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Server.PubSub,
           adapter: Phoenix.PubSub.PG2],
  term: "201708"

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

config :addict,
  secret_key: "243262243132244977506e6c6f4b784246524e733876396a524350454f",
  extra_validation: fn ({valid, errors}, user_params) -> {valid, errors} end, # define extra validation here
  user_schema: Server.User,
  repo: Server.Repo,
  post_login: &(Server.UserActions.login/3),
  post_register: &(Server.UserActions.register/3),
  extra_validation: &(Server.UserActions.validate/2)
