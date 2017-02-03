defmodule Matchr.SkillTest do
  use Matchr.ModelCase

  alias Matchr.Skill

  @valid_attrs %{
    name: "some content",
  }

  test "changeset is valid with valid attributes" do
    changeset = Skill.changeset(%Skill{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset requires name" do
    changeset = Skill.changeset(%Skill{}, %{@valid_attrs | name: nil})
    refute changeset.valid?
  end
end
