defmodule Matchr.MatchTest do
  use Matchr.ModelCase

  alias Matchr.Match

  @valid_attrs %{
    teacher_id: 0,
    learner_id: 0,
    skill_id: 0,
  }

  test "changeset is valid with valid attributes" do
    changeset = Match.changeset(%Match{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset requires teacher_id" do
    changeset = Match.changeset(%Match{}, %{@valid_attrs | teacher_id: nil})
    refute changeset.valid?
  end

  test "changeset requires learner_id" do
    changeset = Match.changeset(%Match{}, %{@valid_attrs | learner_id: nil})
    refute changeset.valid?
  end

  test "changeset requires skill_id" do
    changeset = Match.changeset(%Match{}, %{@valid_attrs | skill_id: nil})
    refute changeset.valid?
  end
end
