defmodule ErpEx.Repo.Migrations.CreateClients do
  use Ecto.Migration

  def change do
    create table(:clients) do
      add :entity_name, :string
      add :contact, :string

      timestamps()
    end
  end
end
