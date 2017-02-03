defmodule Matchr.DatabaseSeeder do
  alias Matchr.Repo
  alias Matchr.User
  alias Matchr.Skill

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
