defmodule ErpEx.Repo.Migrations.CreatePurchaseOrder do
  use Ecto.Migration

  def change do
    create table(:purchase_order) do

      timestamps()
    end
  end
end
