defmodule Invoices.InvoicePage.Invoice do
  use Ecto.Schema
  import Ecto.Changeset

  schema "invoices" do
    @vendors [:asure, :flexsoure, :uds, :american_courier, :pbg, :formax, :go2]
    field :status, Ecto.Enum, values: [:pending, :paid, :cleared], default: :pending
    field :date, :date
    field :amount, :float
    field :invId, :string
    field :vendor, Ecto.Enum, values: @vendors
    timestamps(type: :utc_datetime)
  end

  def changeset(invoice, attrs) do
    invoice
    |> cast(attrs, [:amount, :invId, :vendor, :date, :status])
    # Handle the vendor map
    |> validate_required([:amount, :invId, :vendor, :status, :date])
    |> validate_length(:invId, min: 1, max: 20)
  end
end
