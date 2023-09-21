defmodule ErpEx.Repo.Migrations.CreateProjects do
  use Ecto.Migration

  def change do
    create table(:projects) do
      add :name, :string
      add :description, :string
      add :is_active, :boolean, default: false, null: false

      timestamps()
    end
  end
end
