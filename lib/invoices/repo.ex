defmodule Invoices.Repo do
  use Ecto.Repo,
    otp_app: :invoices,
    adapter: Ecto.Adapters.Postgres
end
