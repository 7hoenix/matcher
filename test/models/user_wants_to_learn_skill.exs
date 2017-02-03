defmodule Matchr.UserWantsToLearnSkillTest do
  use Matchr.ModelCase

  alias Matchr.UserWantsToLearnSkill

  @valid_attrs %{
    user_id: 1,
    skill_id: 1,
  }

  test "changeset is valid with valid attributes" do
    changeset = UserWantsToLearnSkill.changeset(%UserWantsToLearnSkill{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset requires user_id" do changeset = UserWantsToLearnSkill.changeset(%UserWantsToLearnSkill{}, %{@valid_attrs | user_id: nil})
    refute changeset.valid?
  end

  test "changeset requires skill_id" do
    changeset = UserWantsToLearnSkill.changeset(%UserWantsToLearnSkill{}, %{@valid_attrs | skill_id: nil})
    refute changeset.valid?
  end
end

