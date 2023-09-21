defmodule ErpEx.ErpFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ErpEx.Erp` context.
  """

  @doc """
  Generate a project.
  """
  def project_fixture(attrs \\ %{}) do
    {:ok, project} =
      attrs
      |> Enum.into(%{
        name: "some name",
        description: "some description",
        is_active: true
      })
      |> ErpEx.Erp.create_project()

    project
  end

  @doc """
  Generate a purchase_order.
  """
  def purchase_order_fixture(attrs \\ %{}) do
    {:ok, purchase_order} =
      attrs
      |> Enum.into(%{})
      |> ErpEx.Erp.create_purchase_order()

    purchase_order
  end

  @doc """
  Generate a purchase_order.
  """
  def purchase_order_fixture(attrs \\ %{}) do
    {:ok, purchase_order} =
      attrs
      |> Enum.into(%{
        notes: "some notes"
      })
      |> ErpEx.Erp.create_purchase_order()

    purchase_order
  end
end
