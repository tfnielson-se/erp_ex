defmodule ErpEx.Repo do
  use Ecto.Repo,
    otp_app: :erp_ex,
    adapter: Ecto.Adapters.Postgres
end
