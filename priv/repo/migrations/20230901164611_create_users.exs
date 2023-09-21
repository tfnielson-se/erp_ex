defmodule ErpEx.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string
      add :password_hash, :string
      add :title, :string
      add :is_admin, :boolean, default: false, null: false
      add :is_active, :boolean, default: false, null: false
      add :first_name, :string
      add :last_name, :string

      timestamps()
    end
  end
end
