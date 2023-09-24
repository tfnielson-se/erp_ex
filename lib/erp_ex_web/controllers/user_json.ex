defmodule ErpExWeb.UserJSON do
  alias ErpEx.Account.User

  def list_all(_assigns) do
    User.list_all()
  end
end
