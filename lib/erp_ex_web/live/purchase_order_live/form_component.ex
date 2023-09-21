defmodule ErpExWeb.PurchaseOrderLive.FormComponent do
  use ErpExWeb, :live_component

  alias ErpEx.Erp

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage purchase_order records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="purchase_order-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:notes]} type="text" label="Notes" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Purchase order</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{purchase_order: purchase_order} = assigns, socket) do
    changeset = Erp.change_purchase_order(purchase_order)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"purchase_order" => purchase_order_params}, socket) do
    changeset =
      socket.assigns.purchase_order
      |> Erp.change_purchase_order(purchase_order_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"purchase_order" => purchase_order_params}, socket) do
    save_purchase_order(socket, socket.assigns.action, purchase_order_params)
  end

  defp save_purchase_order(socket, :edit, purchase_order_params) do
    case Erp.update_purchase_order(socket.assigns.purchase_order, purchase_order_params) do
      {:ok, purchase_order} ->
        notify_parent({:saved, purchase_order})

        {:noreply,
         socket
         |> put_flash(:info, "Purchase order updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_purchase_order(socket, :new, purchase_order_params) do
    case Erp.create_purchase_order(purchase_order_params) do
      {:ok, purchase_order} ->
        notify_parent({:saved, purchase_order})

        {:noreply,
         socket
         |> put_flash(:info, "Purchase order created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
