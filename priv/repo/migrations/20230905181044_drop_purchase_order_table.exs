defmodule ErpEx.Repo.Migrations.DropPurchaseOrderTable do
  use Ecto.Migration

  def change do
    drop table(:purchase_orders)
  end
end
