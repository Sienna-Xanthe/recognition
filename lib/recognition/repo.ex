defmodule Recognition.Repo do
  use Ecto.Repo,
    otp_app: :recognition,
    adapter: Ecto.Adapters.Postgres
end
