defmodule ErpExWeb.UserController do
  use ErpExWeb, :controller
  alias ErpEx.Repo
  alias ErpEx.Account.User

  def index(conn, _params) do
    render(conn, :list_all, layout: false)
  end
end
