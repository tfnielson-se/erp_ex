defmodule ErpEx.Repo.Migrations.DropClientIdFromPo do
  use Ecto.Migration

  def change do
    drop table("purchase_order")
  end
end
