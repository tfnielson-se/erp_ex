defmodule ErpEx.ErpTest do
  use ErpEx.DataCase

  alias ErpEx.Erp

  describe "items" do
    alias ErpEx.Erp.Item

    import ErpEx.ErpFixtures

    @invalid_attrs %{description: nil, material: nil, vendor: nil, price: nil}

    test "list_items/0 returns all items" do
      item = item_fixture()
      assert Erp.list_items() == [item]
    end

    test "get_item!/1 returns the item with given id" do
      item = item_fixture()
      assert Erp.get_item!(item.id) == item
    end

    test "create_item/1 with valid data creates a item" do
      valid_attrs = %{
        description: "some description",
        material: "some material",
        vendor: "some vendor",
        price: 42
      }

      assert {:ok, %Item{} = item} = Erp.create_item(valid_attrs)
      assert item.description == "some description"
      assert item.material == "some material"
      assert item.vendor == "some vendor"
      assert item.price == 42
    end

    test "create_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Erp.create_item(@invalid_attrs)
    end

    test "update_item/2 with valid data updates the item" do
      item = item_fixture()

      update_attrs = %{
        description: "some updated description",
        material: "some updated material",
        vendor: "some updated vendor",
        price: 43
      }

      assert {:ok, %Item{} = item} = Erp.update_item(item, update_attrs)
      assert item.description == "some updated description"
      assert item.material == "some updated material"
      assert item.vendor == "some updated vendor"
      assert item.price == 43
    end

    test "update_item/2 with invalid data returns error changeset" do
      item = item_fixture()
      assert {:error, %Ecto.Changeset{}} = Erp.update_item(item, @invalid_attrs)
      assert item == Erp.get_item!(item.id)
    end

    test "delete_item/1 deletes the item" do
      item = item_fixture()
      assert {:ok, %Item{}} = Erp.delete_item(item)
      assert_raise Ecto.NoResultsError, fn -> Erp.get_item!(item.id) end
    end

    test "change_item/1 returns a item changeset" do
      item = item_fixture()
      assert %Ecto.Changeset{} = Erp.change_item(item)
    end
  end
end
