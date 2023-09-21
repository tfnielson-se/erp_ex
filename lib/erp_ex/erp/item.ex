defmodule ErpEx.Erp.Item do
  use Ecto.Schema
  import Ecto.Changeset

  alias ErpEx.Repo
  alias ErpEx.Erp.Item

  @required_fields [:material, :description, :vendor, :price]

  schema "items" do
    field :description, :string
    field :material, :string
    field :vendor, :string
    field :price, :integer

    timestamps()
  end

  def changeset(item \\ %__MODULE__{}, attrs) do
    item
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
    |> validate_length(:material, min: 3)
    |> validate_length(:description, min: 10)
  end

  def list_all() do
    Repo.all(Item)
  end

  def get_by_id(item_id) do
    Repo.get!(Item, item_id)
  end

  def create(attrs \\ %{}) do
    attrs
    |> changeset()
    |> Repo.insert()
  end

  def update(item, attrs \\ %{}) do
    item
    |> changeset(attrs)
    |> Repo.update()
  end

  def delete(item) do
    Repo.delete!(item)
  end
end
