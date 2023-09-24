defmodule ErpEx.Account.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias ErpEx.Repo
  alias ErpEx.Account.User
  alias ErpEx.Account.User.{Encrypt, Validate}

  @required_fields [:first_name, :last_name, :email, :title, :password, :is_admin, :is_active]

  @derive {Jason.Encoder, only: [:id, :first_name, :last_name, :email, :title, :password, :is_admin, :is_active]}
  schema "users" do
    field :first_name, :string
    field :last_name, :string
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :title, :string
    field :is_admin, :boolean
    field :is_active, :boolean

    timestamps()
  end

  def changeset(user \\ %__MODULE__{}, attrs) do
    user
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
    |> Validate.run_validations()
    |> Encrypt.run_encrypt()
  end

  def list_all() do
    Repo.all(User)
  end

  def get_by_id(user_id) do
    Repo.get!(User, user_id)
  end

  def create(attrs \\ %{}) do
    attrs
    |> changeset()
    |> Repo.insert()
  end

  def update(user, attrs \\ %{}) do
    user
    |> changeset(attrs)
    |> Repo.update()
  end

  def delete(user) do
    Repo.delete!(user)
  end

end
