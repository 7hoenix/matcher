defmodule Matchr.UsersTest do
  import Matchr.Support.Users
  use Matchr.ModelCase
  alias Matchr.Users

  describe "insert" do
    test "inserts a user" do
      {code, inserted_user} = Users.insert(%{valid_user_attrs | name: "name"})

      assert code == :ok
      assert Users.count == 1
      assert inserted_user.name == "name"
    end

    test "insert returns error code for invalid changeset" do
      {code, _} = Users.insert(%{valid_user_attrs | name: nil})

      assert code == :error
      assert Users.count == 0
    end
  end

  describe "load" do
    test "load user by id" do
      {:ok, inserted_user} = Users.insert(valid_user_attrs)
      user_id = inserted_user.id
      user = Users.load(user_id)

      assert user.id == user_id
    end

    test "load returns nill for invalid id" do
      assert nil == Users.load(9999)
    end
  end

  describe "load_all" do
    test "loads all users" do
      insert_user
      insert_user

      users = Users.load_all()

      assert Enum.count(users) == 2
    end
  end

  describe "update" do
    test "updates user name" do
      {:ok, inserted_user} = Users.insert(valid_user_attrs)
      {:ok, _} = Users.update(inserted_user.id, %{name: "new name"})

      assert Users.load(inserted_user.id).name == "new name"
    end

    test "returns not found for invalid user id" do
      assert {:not_found, _} = Users.update(999, valid_user_attrs)
    end
  end

  describe "delete" do
    test "deletes a user" do
      {:ok, inserted_user} = Users.insert(valid_user_attrs)

      {code, _} = Users.delete(inserted_user.id)
      assert code == :ok
      assert Users.count == 0
    end

    test "returns not found for invalid user" do
      {code, id} = Users.delete(999)

      assert code == :not_found
      assert id == 999
    end
  end
end
