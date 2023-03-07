# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :recognition,
  ecto_repos: [Recognition.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :recognition, RecognitionWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [
    formats: [json: RecognitionWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: Recognition.PubSub,
  live_view: [signing_salt: "WWea4ONG"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :recognition, Recognition.Mailer, adapter: Swoosh.Adapters.Local

config :recognition, RecognitionWeb.Auth.Guardian,
  issuer: "recognition",
  secret_key: "wiQY9EPSRmHjNzoM7mNRTRZrMa9CB7oZTS3Gq5L0BCH2LpMDXENJ33lDZ1qOxmSc" 

config :guardian, Guardian.DB,
   # Add your repository module
   repo: Recognition.Repo,
   # default
   schema_name: "guardian_tokens",
   # token_types: ["refresh_token"], # store all token types if not set
   # default: 60 minutes
   sweep_interval: 60

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
