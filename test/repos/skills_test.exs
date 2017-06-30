defmodule Matchr.SkillsTest do
  use Matchr.ModelCase
  import Matchr.Support.Skills
  alias Matchr.Skills

  describe "insert" do
    test "inserts a skill" do
      {code, inserted_skill} = Skills.insert(%{valid_skill_attrs | name: "name"})

      assert code == :ok
      assert Skills.count == 1
      assert inserted_skill.name == "name"
    end

    test "insert returns error code for invalid changeset" do
      {code, _} = Skills.insert(%{valid_skill_attrs | name: nil})

      assert code == :error
      assert Skills.count == 0
    end
  end

  describe "load" do
    test "load skill by id" do
      {:ok, inserted_skill} = Skills.insert(valid_skill_attrs)
      skill_id = inserted_skill.id
      skill = Skills.load(skill_id)

      assert skill.id == skill_id
    end

    test "returns nill for invalid id" do
      assert nil == Skills.load(9999)
    end
  end

  describe "load_all" do
    test "loads all skills" do
      {:ok, _inserted_skill1} = Skills.insert(valid_skill_attrs)
      {:ok, _inserted_skill2} = Skills.insert(valid_skill_attrs)

      skills = Skills.load_all()

      assert Enum.count(skills) == 2
    end
  end

  describe "update" do
    test "updates skill name" do
      {:ok, inserted_skill} = Skills.insert(valid_skill_attrs)
      {:ok, _} = Skills.update(inserted_skill.id, %{name: "new name"})

      assert Skills.load(inserted_skill.id).name == "new name"
    end

    test "returns not found for invalid skill id" do
      assert {:not_found, _} = Skills.update(999, valid_skill_attrs)
    end
  end

  describe "delete" do
    test "deletes a skill" do
      {:ok, inserted_skill} = Skills.insert(valid_skill_attrs)

      {code, _} = Skills.delete(inserted_skill.id)
      assert code == :ok
      assert Skills.count == 0
    end

    test "returns not found for invalid skill" do
      {code, id} = Skills.delete(999)

      assert code == :not_found
      assert id == 999
    end
  end
end
