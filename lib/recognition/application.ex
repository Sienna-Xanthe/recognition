defmodule Recognition.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      RecognitionWeb.Telemetry,
      # Start the Ecto repository
      Recognition.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Recognition.PubSub},
      # Start Finch
      {Finch, name: Recognition.Finch},
      # Start the Endpoint (http/https)
      RecognitionWeb.Endpoint
      # Start a worker by calling: Recognition.Worker.start_link(arg)
      # {Recognition.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Recognition.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    RecognitionWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
