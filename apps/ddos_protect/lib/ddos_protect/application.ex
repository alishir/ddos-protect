defmodule DDoSProtect.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      DDoSProtect.Repo,
      {DNSCluster, query: Application.get_env(:ddos_protect, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: DDoSProtect.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: DDoSProtect.Finch}
      # Start a worker by calling: DDoSProtect.Worker.start_link(arg)
      # {DDoSProtect.Worker, arg}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: DDoSProtect.Supervisor)
  end
end
