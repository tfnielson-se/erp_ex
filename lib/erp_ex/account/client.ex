defmodule ErpEx.Account.Client do
  use Ecto.Schema
  import Ecto.Changeset

  alias ErpEx.Repo

  @required_fields [:entity_name, :contact]

  schema "clients" do
    field :entity_name, :string
    field :contact, :string

    has_many :purchase_orders, ErpEx.Erp.PurchaseOrder
    timestamps()
  end

  @doc false
  def changeset(client, attrs) do
    client
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
  end

  def list_all() do
    Repo.all(Client)
  end

  def get_by_id(client_id) do
    Repo.get!(Client, client_id)
  end

  def create(client \\ %__MODULE__{}, attrs) do
    client
    |> changeset(attrs)
    |> Repo.insert()
  end

  def update(client, attrs) do
    client
    |> changeset(attrs)
    |> Repo.update()
  end

  def delete(client) do
    Repo.delete(client)
  end
end
