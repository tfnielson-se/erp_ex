defmodule ErpEx.AccountTest do
  use ErpEx.DataCase

  alias ErpEx.Account

  describe "users" do
    alias ErpEx.Account.User

    import ErpEx.AccountFixtures

    @invalid_attrs %{title: nil, email: nil, password_hash: nil, is_admin: nil, is_active: nil, first_name: nil, last_name: nil}

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Account.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Account.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{title: "some title", email: "some email", password_hash: "some password_hash", is_admin: true, is_active: true, first_name: "some first_name", last_name: "some last_name"}

      assert {:ok, %User{} = user} = Account.create_user(valid_attrs)
      assert user.title == "some title"
      assert user.email == "some email"
      assert user.password_hash == "some password_hash"
      assert user.is_admin == true
      assert user.is_active == true
      assert user.first_name == "some first_name"
      assert user.last_name == "some last_name"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Account.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      update_attrs = %{title: "some updated title", email: "some updated email", password_hash: "some updated password_hash", is_admin: false, is_active: false, first_name: "some updated first_name", last_name: "some updated last_name"}

      assert {:ok, %User{} = user} = Account.update_user(user, update_attrs)
      assert user.title == "some updated title"
      assert user.email == "some updated email"
      assert user.password_hash == "some updated password_hash"
      assert user.is_admin == false
      assert user.is_active == false
      assert user.first_name == "some updated first_name"
      assert user.last_name == "some updated last_name"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Account.update_user(user, @invalid_attrs)
      assert user == Account.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Account.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Account.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Account.change_user(user)
    end
  end

  describe "clients" do
    alias ErpEx.Account.Client

    import ErpEx.AccountFixtures

    @invalid_attrs %{entity_name: nil, contact: nil}

    test "list_clients/0 returns all clients" do
      client = client_fixture()
      assert Account.list_clients() == [client]
    end

    test "get_client!/1 returns the client with given id" do
      client = client_fixture()
      assert Account.get_client!(client.id) == client
    end

    test "create_client/1 with valid data creates a client" do
      valid_attrs = %{entity_name: "some entity_name", contact: "some contact"}

      assert {:ok, %Client{} = client} = Account.create_client(valid_attrs)
      assert client.entity_name == "some entity_name"
      assert client.contact == "some contact"
    end

    test "create_client/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Account.create_client(@invalid_attrs)
    end

    test "update_client/2 with valid data updates the client" do
      client = client_fixture()
      update_attrs = %{entity_name: "some updated entity_name", contact: "some updated contact"}

      assert {:ok, %Client{} = client} = Account.update_client(client, update_attrs)
      assert client.entity_name == "some updated entity_name"
      assert client.contact == "some updated contact"
    end

    test "update_client/2 with invalid data returns error changeset" do
      client = client_fixture()
      assert {:error, %Ecto.Changeset{}} = Account.update_client(client, @invalid_attrs)
      assert client == Account.get_client!(client.id)
    end

    test "delete_client/1 deletes the client" do
      client = client_fixture()
      assert {:ok, %Client{}} = Account.delete_client(client)
      assert_raise Ecto.NoResultsError, fn -> Account.get_client!(client.id) end
    end

    test "change_client/1 returns a client changeset" do
      client = client_fixture()
      assert %Ecto.Changeset{} = Account.change_client(client)
    end
  end
end
