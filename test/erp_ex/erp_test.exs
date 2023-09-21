defmodule ErpEx.ErpTest do
  use ErpEx.DataCase

  alias ErpEx.Erp

  describe "projects" do
    alias ErpEx.Erp.Project

    import ErpEx.ErpFixtures

    @invalid_attrs %{name: nil, description: nil, is_active: nil}

    test "list_projects/0 returns all projects" do
      project = project_fixture()
      assert Erp.list_projects() == [project]
    end

    test "get_project!/1 returns the project with given id" do
      project = project_fixture()
      assert Erp.get_project!(project.id) == project
    end

    test "create_project/1 with valid data creates a project" do
      valid_attrs = %{name: "some name", description: "some description", is_active: true}

      assert {:ok, %Project{} = project} = Erp.create_project(valid_attrs)
      assert project.name == "some name"
      assert project.description == "some description"
      assert project.is_active == true
    end

    test "create_project/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Erp.create_project(@invalid_attrs)
    end

    test "update_project/2 with valid data updates the project" do
      project = project_fixture()

      update_attrs = %{
        name: "some updated name",
        description: "some updated description",
        is_active: false
      }

      assert {:ok, %Project{} = project} = Erp.update_project(project, update_attrs)
      assert project.name == "some updated name"
      assert project.description == "some updated description"
      assert project.is_active == false
    end

    test "update_project/2 with invalid data returns error changeset" do
      project = project_fixture()
      assert {:error, %Ecto.Changeset{}} = Erp.update_project(project, @invalid_attrs)
      assert project == Erp.get_project!(project.id)
    end

    test "delete_project/1 deletes the project" do
      project = project_fixture()
      assert {:ok, %Project{}} = Erp.delete_project(project)
      assert_raise Ecto.NoResultsError, fn -> Erp.get_project!(project.id) end
    end

    test "change_project/1 returns a project changeset" do
      project = project_fixture()
      assert %Ecto.Changeset{} = Erp.change_project(project)
    end
  end

  describe "purchase_order" do
    alias ErpEx.Erp.Purchase_Order

    import ErpEx.ErpFixtures

    @invalid_attrs %{}

    test "list_purchase_order/0 returns all purchase_order" do
      purchase_order = purchase_order_fixture()
      assert Erp.list_purchase_order() == [purchase_order]
    end

    test "get_purchase_order!/1 returns the purchase_order with given id" do
      purchase_order = purchase_order_fixture()
      assert Erp.get_purchase_order!(purchase_order.id) == purchase_order
    end

    test "create_purchase_order/1 with valid data creates a purchase_order" do
      valid_attrs = %{}

      assert {:ok, %Purchase_Order{} = purchase_order} = Erp.create_purchase_order(valid_attrs)
    end

    test "create_purchase_order/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Erp.create_purchase_order(@invalid_attrs)
    end

    test "update_purchase_order/2 with valid data updates the purchase_order" do
      purchase_order = purchase_order_fixture()
      update_attrs = %{}

      assert {:ok, %Purchase_Order{} = purchase_order} =
               Erp.update_purchase_order(purchase_order, update_attrs)
    end

    test "update_purchase_order/2 with invalid data returns error changeset" do
      purchase_order = purchase_order_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Erp.update_purchase_order(purchase_order, @invalid_attrs)

      assert purchase_order == Erp.get_purchase_order!(purchase_order.id)
    end

    test "delete_purchase_order/1 deletes the purchase_order" do
      purchase_order = purchase_order_fixture()
      assert {:ok, %Purchase_Order{}} = Erp.delete_purchase_order(purchase_order)
      assert_raise Ecto.NoResultsError, fn -> Erp.get_purchase_order!(purchase_order.id) end
    end

    test "change_purchase_order/1 returns a purchase_order changeset" do
      purchase_order = purchase_order_fixture()
      assert %Ecto.Changeset{} = Erp.change_purchase_order(purchase_order)
    end
  end

  describe "purchase_orders" do
    alias ErpEx.Erp.Purchase_Order

    import ErpEx.ErpFixtures

    @invalid_attrs %{}

    test "list_purchase_orders/0 returns all purchase_orders" do
      purchase_order = purchase_order_fixture()
      assert Erp.list_purchase_orders() == [purchase_order]
    end

    test "get_purchase_order!/1 returns the purchase_order with given id" do
      purchase_order = purchase_order_fixture()
      assert Erp.get_purchase_order!(purchase_order.id) == purchase_order
    end

    test "create_purchase_order/1 with valid data creates a purchase_order" do
      valid_attrs = %{}

      assert {:ok, %Purchase_Order{} = purchase_order} = Erp.create_purchase_order(valid_attrs)
    end

    test "create_purchase_order/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Erp.create_purchase_order(@invalid_attrs)
    end

    test "update_purchase_order/2 with valid data updates the purchase_order" do
      purchase_order = purchase_order_fixture()
      update_attrs = %{}

      assert {:ok, %Purchase_Order{} = purchase_order} =
               Erp.update_purchase_order(purchase_order, update_attrs)
    end

    test "update_purchase_order/2 with invalid data returns error changeset" do
      purchase_order = purchase_order_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Erp.update_purchase_order(purchase_order, @invalid_attrs)

      assert purchase_order == Erp.get_purchase_order!(purchase_order.id)
    end

    test "delete_purchase_order/1 deletes the purchase_order" do
      purchase_order = purchase_order_fixture()
      assert {:ok, %Purchase_Order{}} = Erp.delete_purchase_order(purchase_order)
      assert_raise Ecto.NoResultsError, fn -> Erp.get_purchase_order!(purchase_order.id) end
    end

    test "change_purchase_order/1 returns a purchase_order changeset" do
      purchase_order = purchase_order_fixture()
      assert %Ecto.Changeset{} = Erp.change_purchase_order(purchase_order)
    end
  end

  describe "purchase_orders" do
    alias ErpEx.Erp.PurchaseOrder

    import ErpEx.ErpFixtures

    @invalid_attrs %{notes: nil}

    test "list_purchase_orders/0 returns all purchase_orders" do
      purchase_order = purchase_order_fixture()
      assert Erp.list_purchase_orders() == [purchase_order]
    end

    test "get_purchase_order!/1 returns the purchase_order with given id" do
      purchase_order = purchase_order_fixture()
      assert Erp.get_purchase_order!(purchase_order.id) == purchase_order
    end

    test "create_purchase_order/1 with valid data creates a purchase_order" do
      valid_attrs = %{notes: "some notes"}

      assert {:ok, %PurchaseOrder{} = purchase_order} = Erp.create_purchase_order(valid_attrs)
      assert purchase_order.notes == "some notes"
    end

    test "create_purchase_order/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Erp.create_purchase_order(@invalid_attrs)
    end

    test "update_purchase_order/2 with valid data updates the purchase_order" do
      purchase_order = purchase_order_fixture()
      update_attrs = %{notes: "some updated notes"}

      assert {:ok, %PurchaseOrder{} = purchase_order} = Erp.update_purchase_order(purchase_order, update_attrs)
      assert purchase_order.notes == "some updated notes"
    end

    test "update_purchase_order/2 with invalid data returns error changeset" do
      purchase_order = purchase_order_fixture()
      assert {:error, %Ecto.Changeset{}} = Erp.update_purchase_order(purchase_order, @invalid_attrs)
      assert purchase_order == Erp.get_purchase_order!(purchase_order.id)
    end

    test "delete_purchase_order/1 deletes the purchase_order" do
      purchase_order = purchase_order_fixture()
      assert {:ok, %PurchaseOrder{}} = Erp.delete_purchase_order(purchase_order)
      assert_raise Ecto.NoResultsError, fn -> Erp.get_purchase_order!(purchase_order.id) end
    end

    test "change_purchase_order/1 returns a purchase_order changeset" do
      purchase_order = purchase_order_fixture()
      assert %Ecto.Changeset{} = Erp.change_purchase_order(purchase_order)
    end
  end
end
