defmodule Matchr.UserTest do
  use Matchr.ModelCase

  alias Matchr.User

  @valid_attrs %{
    name: "some content",
  }

  test "changeset is valid with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset requires name" do
    changeset = User.changeset(%User{}, %{@valid_attrs | name: nil})
    refute changeset.valid?
  end
end
