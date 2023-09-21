defmodule ErpEx.Repo.Migrations.CreatePurchaseOrders do
  use Ecto.Migration

  def change do
    create table(:purchase_orders) do
      add :notes, :string
      add :client_id, references(:clients, on_delete: :nothing)

      timestamps()
    end

    create index(:purchase_orders, [:client_id])
  end
end
