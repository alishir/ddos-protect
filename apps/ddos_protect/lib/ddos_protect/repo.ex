defmodule DDoSProtect.Repo do
  use Ecto.Repo,
    otp_app: :ddos_protect,
    adapter: Ecto.Adapters.Postgres
end
