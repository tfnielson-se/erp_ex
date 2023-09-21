defmodule ErpExWeb.ItemLive.Show do
  use ErpExWeb, :live_view

  alias ErpEx.Erp

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:item, Erp.get_item!(id))}
  end

  defp page_title(:show), do: "Show Item"
  defp page_title(:edit), do: "Edit Item"
end
