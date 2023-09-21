defmodule ErpExWeb.ClientLive.FormComponent do
  use ErpExWeb, :live_component

  alias ErpEx.Account

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage client records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="client-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:entity_name]} type="text" label="Entity name" />
        <.input field={@form[:contact]} type="text" label="Contact" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Client</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{client: client} = assigns, socket) do
    changeset = Account.change_client(client)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"client" => client_params}, socket) do
    changeset =
      socket.assigns.client
      |> Account.change_client(client_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"client" => client_params}, socket) do
    save_client(socket, socket.assigns.action, client_params)
  end

  defp save_client(socket, :edit, client_params) do
    case Account.update_client(socket.assigns.client, client_params) do
      {:ok, client} ->
        notify_parent({:saved, client})

        {:noreply,
         socket
         |> put_flash(:info, "Client updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_client(socket, :new, client_params) do
    case Account.create_client(client_params) do
      {:ok, client} ->
        notify_parent({:saved, client})

        {:noreply,
         socket
         |> put_flash(:info, "Client created successfully")
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
