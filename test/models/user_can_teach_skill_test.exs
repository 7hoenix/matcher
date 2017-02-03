defmodule Matchr.UserCanTeachSkillTest do
  use Matchr.ModelCase

  alias Matchr.UserCanTeachSkill

  @valid_attrs %{
    user_id: 1,
    skill_id: 1,
  }

  test "changeset is valid with valid attributes" do
    changeset = UserCanTeachSkill.changeset(%UserCanTeachSkill{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset requires user_id" do changeset = UserCanTeachSkill.changeset(%UserCanTeachSkill{}, %{@valid_attrs | user_id: nil})
    refute changeset.valid?
  end

  test "changeset requires skill_id" do
    changeset = UserCanTeachSkill.changeset(%UserCanTeachSkill{}, %{@valid_attrs | skill_id: nil})
    refute changeset.valid?
  end
end

