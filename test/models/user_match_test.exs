defmodule Matcher.UserMatchTest do
  use Matcher.ModelCase

  alias Matcher.UserMatch
  alias Matcher.User
  alias Matcher.Skill

  @valid_attrs %{}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = UserMatch.changeset(%UserMatch{}, @valid_attrs)
    # assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = UserMatch.changeset(%UserMatch{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "entries are unique on teacher, learner and skill." do
    user1 = Repo.insert!(%User{name: "Lovelace"})
    user2 = Repo.insert!(%User{name: "Turing"})
    skill = Repo.insert!(%Skill{name: "sketch"})
    user_match_1 = Repo.insert!(%UserMatch{teacher_id: user2.id, learner_id: user1.id, status: 0, skill_id: skill.id})

    repeat_user_match = Repo.insert!(%UserMatch{teacher_id: user2.id, learner_id: user1.id, status: 1, skill_id: skill.id})

    refute repeat_user_match.id
  end
end
