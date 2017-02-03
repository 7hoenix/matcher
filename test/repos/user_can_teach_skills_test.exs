defmodule Matchr.UserCanTeachSkillsTest do
  use Matchr.ModelCase
  alias Matchr.UserCanTeachSkills
  alias Matchr.Users
  alias Matchr.Skills

  @valid_user_skill_attrs %{
    user_id: 1,
    skill_id: 1,
  }

  @valid_user_attrs %{
    name: "user name",
  }

  @valid_skill_attrs %{
    name: "skill name",
  }

  describe "insert" do
    test "inserts a user_skill" do
      {:ok, user} = Users.insert(@valid_user_attrs)
      {:ok, skill} = Skills.insert(@valid_skill_attrs)
      {code, inserted_user_skill} = UserCanTeachSkills.insert(%{@valid_user_skill_attrs | user_id: user.id, skill_id: skill.id})

      assert code == :ok
      assert UserCanTeachSkills.count == 1
      assert inserted_user_skill.user_id == user.id
      assert inserted_user_skill.skill_id == skill.id
    end

    test "insert returns error code for invalid changeset" do
      {code, _} = UserCanTeachSkills.insert(%{@valid_user_skill_attrs | user_id: nil})

      assert code == :error
      assert UserCanTeachSkills.count == 0
    end
  end

  describe "delete" do
    test "deletes a user_skill" do
      {:ok, user} = Users.insert(@valid_user_attrs)
      {:ok, skill} = Skills.insert(@valid_skill_attrs)
      {:ok, inserted_user_skill} = UserCanTeachSkills.insert(%{@valid_user_skill_attrs | user_id: user.id, skill_id: skill.id})

      {code, _} = UserCanTeachSkills.delete(inserted_user_skill.id)
      assert code == :ok
      assert UserCanTeachSkills.count == 0
    end

    test "returns not found for invalid user_skill" do
      {code, id} = UserCanTeachSkills.delete(999)

      assert code == :not_found
      assert id == 999
    end
  end
end
