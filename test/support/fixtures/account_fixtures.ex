defmodule ErpEx.AccountFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ErpEx.Account` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        title: "some title",
        email: "some email",
        password_hash: "some password_hash",
        is_admin: true,
        is_active: true,
        first_name: "some first_name",
        last_name: "some last_name"
      })
      |> ErpEx.Account.create_user()

    user
  end

  @doc """
  Generate a client.
  """
  def client_fixture(attrs \\ %{}) do
    {:ok, client} =
      attrs
      |> Enum.into(%{
        entity_name: "some entity_name",
        contact: "some contact"
      })
      |> ErpEx.Account.create_client()

    client
  end
end
