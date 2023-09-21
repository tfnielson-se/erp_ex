defmodule ErpExWeb.PurchaseOrderLive.Index do
  use ErpExWeb, :live_view

  alias ErpEx.Erp
  alias ErpEx.Erp.PurchaseOrder

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :purchase_orders, Erp.list_purchase_orders())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Purchase order")
    |> assign(:purchase_order, Erp.get_purchase_order!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Purchase order")
    |> assign(:purchase_order, %PurchaseOrder{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Purchase orders")
    |> assign(:purchase_order, nil)
  end

  @impl true
  def handle_info({ErpExWeb.PurchaseOrderLive.FormComponent, {:saved, purchase_order}}, socket) do
    {:noreply, stream_insert(socket, :purchase_orders, purchase_order)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    purchase_order = Erp.get_purchase_order!(id)
    {:ok, _} = Erp.delete_purchase_order(purchase_order)

    {:noreply, stream_delete(socket, :purchase_orders, purchase_order)}
  end
end
