defmodule Matchr.SkillTest do
  use Matchr.ModelCase
  import Matchr.Support.Skills
  alias Matchr.Skill

  test "changeset is valid with valid attributes" do
    changeset = Skill.changeset(%Skill{}, valid_skill_attrs)
    assert changeset.valid?
  end

  test "changeset requires name" do
    changeset = Skill.changeset(%Skill{}, %{valid_skill_attrs | name: nil})
    refute changeset.valid?
  end
end
