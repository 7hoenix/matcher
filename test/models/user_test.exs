defmodule Matchr.UserTest do
  use Matchr.ModelCase
  import Matchr.Support.Users

  alias Matchr.User

  test "changeset is valid with valid attributes" do
    changeset = User.changeset(%User{}, valid_user_attrs)
    assert changeset.valid?
  end

  test "changeset requires name" do
    changeset = User.changeset(%User{}, %{valid_user_attrs | name: nil})
    refute changeset.valid?
  end
end
