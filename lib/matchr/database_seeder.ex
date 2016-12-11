defmodule Matchr.DatabaseSeeder do
  alias Matchr.Repo
  alias Matchr.User
  alias Matchr.Skill
  alias Matchr.UserSkill

  def insert_user(name) do
    Repo.insert! %User{
      name: name
    }
  end

  def insert_skill(name) do
    Repo.insert! %Skill{
      name: name
    }
  end

  def insert_user_skill(user, skill) do
    Repo.insert! %UserSkill{
      user_id: user.id,
      skill_id: skill.id,
      can_teach: Enum.take_random([true, false], 1) |> Enum.at(0)
    }
  end

  def take_random_from(entries) do
    entries
    |> Enum.take_random(1)
    |> Enum.at(0)
  end

  def clear do
    Repo.delete_all UserSkill
    Repo.delete_all Skill
    Repo.delete_all User
  end
end
