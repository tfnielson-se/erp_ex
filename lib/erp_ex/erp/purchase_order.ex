defmodule ErpEx.Erp.PurchaseOrder do
  use Ecto.Schema
  import Ecto.Changeset

  alias ErpEx.Repo

  schema "purchase_orders" do
    field :notes, :string
    # field :client_id, :id

    belongs_to :client, ErpEx.Account.Client, define_field: true
    timestamps()
  end

  @doc false
  def changeset(purchase_order \\ %__MODULE__{}, attrs) do
    purchase_order
    |> cast(attrs, [:notes, :client_id])
    |> validate_required([:notes, :client_id])
  end

  def create(attrs \\ %{}) do
    attrs
    |> changeset()
    |> Repo.insert()
  end
end
