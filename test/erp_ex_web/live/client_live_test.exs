defmodule ErpExWeb.ClientLiveTest do
  use ErpExWeb.ConnCase

  import Phoenix.LiveViewTest
  import ErpEx.AccountFixtures

  @create_attrs %{entity_name: "some entity_name", contact: "some contact"}
  @update_attrs %{entity_name: "some updated entity_name", contact: "some updated contact"}
  @invalid_attrs %{entity_name: nil, contact: nil}

  defp create_client(_) do
    client = client_fixture()
    %{client: client}
  end

  describe "Index" do
    setup [:create_client]

    test "lists all clients", %{conn: conn, client: client} do
      {:ok, _index_live, html} = live(conn, ~p"/clients")

      assert html =~ "Listing Clients"
      assert html =~ client.entity_name
    end

    test "saves new client", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/clients")

      assert index_live |> element("a", "New Client") |> render_click() =~
               "New Client"

      assert_patch(index_live, ~p"/clients/new")

      assert index_live
             |> form("#client-form", client: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#client-form", client: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/clients")

      html = render(index_live)
      assert html =~ "Client created successfully"
      assert html =~ "some entity_name"
    end

    test "updates client in listing", %{conn: conn, client: client} do
      {:ok, index_live, _html} = live(conn, ~p"/clients")

      assert index_live |> element("#clients-#{client.id} a", "Edit") |> render_click() =~
               "Edit Client"

      assert_patch(index_live, ~p"/clients/#{client}/edit")

      assert index_live
             |> form("#client-form", client: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#client-form", client: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/clients")

      html = render(index_live)
      assert html =~ "Client updated successfully"
      assert html =~ "some updated entity_name"
    end

    test "deletes client in listing", %{conn: conn, client: client} do
      {:ok, index_live, _html} = live(conn, ~p"/clients")

      assert index_live |> element("#clients-#{client.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#clients-#{client.id}")
    end
  end

  describe "Show" do
    setup [:create_client]

    test "displays client", %{conn: conn, client: client} do
      {:ok, _show_live, html} = live(conn, ~p"/clients/#{client}")

      assert html =~ "Show Client"
      assert html =~ client.entity_name
    end

    test "updates client within modal", %{conn: conn, client: client} do
      {:ok, show_live, _html} = live(conn, ~p"/clients/#{client}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Client"

      assert_patch(show_live, ~p"/clients/#{client}/show/edit")

      assert show_live
             |> form("#client-form", client: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#client-form", client: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/clients/#{client}")

      html = render(show_live)
      assert html =~ "Client updated successfully"
      assert html =~ "some updated entity_name"
    end
  end
end
