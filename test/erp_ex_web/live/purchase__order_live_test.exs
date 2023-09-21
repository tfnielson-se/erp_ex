defmodule ErpExWeb.Purchase_OrderLiveTest do
  use ErpExWeb.ConnCase

  import Phoenix.LiveViewTest
  import ErpEx.ErpFixtures

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  defp create_purchase_order(_) do
    purchase_order = purchase_order_fixture()
    %{purchase_order: purchase_order}
  end

  describe "Index" do
    setup [:create_purchase_order]

    test "lists all purchase_orders", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, ~p"/purchase_orders")

      assert html =~ "Listing Purchase orders"
    end

    test "saves new purchase_order", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/purchase_orders")

      assert index_live |> element("a", "New Purchase  order") |> render_click() =~
               "New Purchase  order"

      assert_patch(index_live, ~p"/purchase_orders/new")

      assert index_live
             |> form("#purchase_order-form", purchase_order: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#purchase_order-form", purchase_order: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/purchase_orders")

      html = render(index_live)
      assert html =~ "Purchase  order created successfully"
    end

    test "updates purchase_order in listing", %{conn: conn, purchase_order: purchase_order} do
      {:ok, index_live, _html} = live(conn, ~p"/purchase_orders")

      assert index_live
             |> element("#purchase_orders-#{purchase_order.id} a", "Edit")
             |> render_click() =~
               "Edit Purchase  order"

      assert_patch(index_live, ~p"/purchase_orders/#{purchase_order}/edit")

      assert index_live
             |> form("#purchase_order-form", purchase_order: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#purchase_order-form", purchase_order: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/purchase_orders")

      html = render(index_live)
      assert html =~ "Purchase  order updated successfully"
    end

    test "deletes purchase_order in listing", %{conn: conn, purchase_order: purchase_order} do
      {:ok, index_live, _html} = live(conn, ~p"/purchase_orders")

      assert index_live
             |> element("#purchase_orders-#{purchase_order.id} a", "Delete")
             |> render_click()

      refute has_element?(index_live, "#purchase_orders-#{purchase_order.id}")
    end
  end

  describe "Show" do
    setup [:create_purchase_order]

    test "displays purchase_order", %{conn: conn, purchase_order: purchase_order} do
      {:ok, _show_live, html} = live(conn, ~p"/purchase_orders/#{purchase_order}")

      assert html =~ "Show Purchase  order"
    end

    test "updates purchase_order within modal", %{conn: conn, purchase_order: purchase_order} do
      {:ok, show_live, _html} = live(conn, ~p"/purchase_orders/#{purchase_order}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Purchase  order"

      assert_patch(show_live, ~p"/purchase_orders/#{purchase_order}/show/edit")

      assert show_live
             |> form("#purchase_order-form", purchase_order: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#purchase_order-form", purchase_order: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/purchase_orders/#{purchase_order}")

      html = render(show_live)
      assert html =~ "Purchase  order updated successfully"
    end
  end
end
