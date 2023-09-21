defmodule ErpEx.Repo.Migrations.AddClientToPo do
  use Ecto.Migration

  def change do
    alter table(:purchase_order) do
      add :client_id, references("clients")
    end
  end
end
