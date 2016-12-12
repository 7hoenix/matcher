defmodule Matcher.UserSkillTest do
  use Matcher.ModelCase

  alias Matcher.UserSkill

  @valid_attrs %{active: true, can_teach: true}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = UserSkill.changeset(%UserSkill{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = UserSkill.changeset(%UserSkill{}, @invalid_attrs)
    refute changeset.valid?
  end
end
