defmodule ErpEx.Account.User.Validate do
  import Ecto.Changeset

  def run_validations(changeset) do
    changeset
    |> validate_length(:last_name, min: 3)
    |> validate_length(:first_name, min: 3)
    |> validate_format(:email, ~r/@/)
  end

end
