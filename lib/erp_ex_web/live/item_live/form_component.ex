defmodule ErpExWeb.ItemLive.FormComponent do
  use ErpExWeb, :live_component

  alias ErpEx.Erp

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage item records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="item-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:material]} type="text" label="Erp" />
        <.input field={@form[:description]} type="text" label="Description" />
        <.input field={@form[:vendor]} type="text" label="Vendor" />
        <.input field={@form[:price]} type="number" label="Price" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Item</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{item: item} = assigns, socket) do
    changeset = Erp.change_item(item)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"item" => item_params}, socket) do
    changeset =
      socket.assigns.item
      |> Erp.change_item(item_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"item" => item_params}, socket) do
    save_item(socket, socket.assigns.action, item_params)
  end

  defp save_item(socket, :edit, item_params) do
    case Erp.update_item(socket.assigns.item, item_params) do
      {:ok, item} ->
        notify_parent({:saved, item})

        {:noreply,
         socket
         |> put_flash(:info, "Item updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_item(socket, :new, item_params) do
    case Erp.create_item(item_params) do
      {:ok, item} ->
        notify_parent({:saved, item})

        {:noreply,
         socket
         |> put_flash(:info, "Item created successfully")
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
