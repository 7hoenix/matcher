defmodule Matchr.UserCanTeachSkills do
  use Matchr.Repo
  alias Matchr.UserCanTeachSkill

  def insert(user_skill_attributes) do
    UserCanTeachSkill.changeset(%UserCanTeachSkill{}, user_skill_attributes)
    |> Repo.insert
  end

  def load(id) do case Repo.get(UserCanTeachSkill, id) do
      nil -> nil
      user_skill -> user_skill
        |> Repo.preload(:user)
        |> Repo.preload(:skill)
    end
  end

  def delete(id) do
    case load(id) do
      nil -> {:not_found, id}
      user_skill ->  Repo.delete(user_skill)
    end
  end

  def count() do
    Repo.aggregate(UserCanTeachSkill, :count, :id)
  end
end
