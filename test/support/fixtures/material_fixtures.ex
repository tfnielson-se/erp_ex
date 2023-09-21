defmodule ErpEx.ErpFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ErpEx.Erp` context.
  """

  @doc """
  Generate a item.
  """
  def item_fixture(attrs \\ %{}) do
    {:ok, item} =
      attrs
      |> Enum.into(%{
        description: "some description",
        material: "some material",
        vendor: "some vendor",
        price: 42
      })
      |> ErpEx.Erp.create_item()

    item
  end
end
