defmodule ErpExWeb.UserController do
  use ErpExWeb, :controller
  alias ErpEx.Repo
  alias ErpEx.Account.User

  def index(conn, _params) do
    user = Repo.get!(User, 1)

    json(conn, %{user: user.first_name})
  end
end
