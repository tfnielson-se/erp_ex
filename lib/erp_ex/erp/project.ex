defmodule ErpEx.Erp.Project do
  use Ecto.Schema
  import Ecto.Changeset

  alias ErpEx.Repo

  schema "projects" do
    field :name, :string
    field :description, :string
    field :is_active, :boolean, default: false

    timestamps()
  end

  @doc false
  def changeset(project, attrs) do
    project
    |> cast(attrs, [:name, :description, :is_active])
    |> validate_required([:name, :description, :is_active])
  end

  def list_all() do
    Repo.all(Project)
  end

  def get_by_id(project_id) do
    Repo.get!(Project, project_id)
  end

  def create(project \\ %__MODULE__{}, attrs) do
    project
    |> changeset(attrs)
    |> Repo.insert()
  end

  def update(project, attrs) do
    project
    |> changeset(attrs)
    |> Repo.update()
  end

  def delete(project) do
    Repo.delete!(project)
  end


end
