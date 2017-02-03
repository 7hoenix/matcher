defmodule Matchr.UserWantsToLearnSkills do
  use Matchr.Repo
  alias Matchr.UserWantsToLearnSkill

  def insert(user_skill_attributes) do
    UserWantsToLearnSkill.changeset(%UserWantsToLearnSkill{}, user_skill_attributes)
    |> Repo.insert
  end

  def load(id) do case Repo.get(UserWantsToLearnSkill, id) do
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
    Repo.aggregate(UserWantsToLearnSkill, :count, :id)
  end
end
