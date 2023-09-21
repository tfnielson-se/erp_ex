defmodule ErpEx.Repo.Migrations.CreateItems do
  use Ecto.Migration

  def change do
    create table(:items) do
      add :material, :string
      add :description, :string
      add :vendor, :string
      add :price, :integer

      timestamps()
    end
  end
end
