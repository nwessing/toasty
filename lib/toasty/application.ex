defmodule Toasty.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      ToastyWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Toasty.PubSub},
      # Start the Endpoint (http/https)
      ToastyWeb.Endpoint,
      # Start a worker by calling: Toasty.Worker.start_link(arg)
      # {Toasty.Worker, arg}
      {Toasty.ToastServer, name: Toasty.ToastServer}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Toasty.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    ToastyWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
