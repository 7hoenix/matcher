defmodule Matchr.MatchGeneratorTest do
  use Matchr.ModelCase
  import Matchr.Support.Users
  alias Matchr.Skills
  alias Matchr.Users
  alias Matchr.MatchGenerator

  def insert_skill(skill_attributes \\ %{}) do
    %{
      name: "skill name",
    }
    |> Map.merge(skill_attributes)
    |> Skills.insert
  end

  def skill_id(skill) do
    skill.id
  end

  test "removes skills with no teacher" do
    {:ok, user1} = insert_user()
    {:ok, user2} = insert_user()
    insert_skill
    insert_skill(%{name: "two", learners: [user1], teachers: [user2]})

    skills = Skills.load_all
    |> MatchGenerator.remove_skills_with_no_teachers_or_no_learners

    assert length(skills) == 1
  end

  test "removes skills with no learner" do
    {:ok, user1} = insert_user()
    {:ok, user2} = insert_user()
    insert_skill
    insert_skill(%{name: "two", learners: [user1], teachers: [user2]})

    skills = Skills.load_all
    |> MatchGenerator.remove_skills_with_no_teachers_or_no_learners

    assert length(skills) == 1
  end

  test "sorts skills based on difference between learners and teachers" do
    {:ok, user1} = insert_user()
    {:ok, user2} = insert_user()
    {:ok, user3} = insert_user()
    {:ok, user4} = insert_user()
    {:ok, skill1} = insert_skill(%{name: "one", learners: [user1, user2, user3, user4], teachers: [user2, user3, user4]})
    {:ok, skill2} = insert_skill(%{name: "one", learners: [user4], teachers: [user2]})
    {:ok, skill3} = insert_skill(%{name: "one", learners: [user3, user4, user2], teachers: [user2]})
    {:ok, skill4} = insert_skill(%{name: "one", learners: [user1, user2, user3, user4], teachers: [user2]})

    skills = Skills.load_all
      |> MatchGenerator.sort_skills

    assert Enum.map(skills, &skill_id/1) == [skill4.id, skill3.id, skill1.id, skill2.id]
  end

  test "simple match with no remaining" do
    {:ok, user1} = insert_user()
    {:ok, user2} = insert_user()
    {:ok, skill} = insert_skill(%{name: "RUBY", learners: [user1], teachers: [user2]})
    available_users = Users.load_all

    {matches, remaining_users} = Skills.load_all
      |> MatchGenerator.sort_skills
      |> MatchGenerator.match_users(available_users)

    assert matches == [
      %{learner_id: user1.id, teacher_id: user2.id, skill_id: skill.id},
    ]
    assert remaining_users == []
  end

  test "match two skills with a remaining" do
    {:ok, user1} = insert_user()
    {:ok, user2} = insert_user()
    {:ok, user3} = insert_user()
    {:ok, user4} = insert_user()
    {:ok, user5} = insert_user()
    {:ok, skill} = insert_skill(%{name: "RUBY", learners: [user1], teachers: [user3, user4]})
    {:ok, skill2} = insert_skill(%{name: "SKETCH", learners: [user4], teachers: [user2]})
    available_users = Users.load_all

    {matches, remaining_users} = Skills.load_all
      |> MatchGenerator.remove_skills_with_no_teachers_or_no_learners
      |> MatchGenerator.sort_skills
      |> MatchGenerator.match_users(available_users)

    assert matches == [
      %{learner_id: user4.id, teacher_id: user2.id, skill_id: skill2.id},
      %{learner_id: user1.id, teacher_id: user3.id, skill_id: skill.id},
    ]
    assert remaining_users == [user5.id]
  end
end
