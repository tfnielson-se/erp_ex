defmodule ErpEx.Account.User.Encrypt do
  import Ecto.Changeset

  def run_encrypt(changeset) do
    changeset
    |> put_pass_hash()
  end

  defp put_pass_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, %{password_hash: Argon2.hash_pwd_salt(password)})
  end

  defp put_pass_hash(changeset), do: changeset
end
