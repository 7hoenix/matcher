defmodule Matchr.Skills do
  use Matchr.Repo
  alias Matchr.Skill

  def insert(skill_attributes) do
    Skill.changeset(%Skill{}, skill_attributes)
    |> assoc_users(skill_attributes)
    |> Repo.insert
  end

  def update(id, skill_attributes) do
    case load(id) do
      nil -> {:not_found, id}
      skill ->
        Skill.changeset(skill, skill_attributes)
        |> assoc_users(skill_attributes)
        |> Repo.update
    end
  end

  defp assoc_users(changeset, skill_attributes) do
   changeset
    |> assoc_users_that_want_to_learn(skill_attributes)
    |> assoc_users_that_can_teach(skill_attributes)
  end

  defp assoc_users_that_want_to_learn(changeset, skill_attributes) do
    case skill_attributes[:users_that_want_to_learn] do
      nil -> changeset
      _ -> Ecto.Changeset.put_assoc(changeset, :users_that_want_to_learn, skill_attributes[:users_that_want_to_learn])
    end
  end

  defp assoc_users_that_can_teach(changeset, skill_attributes) do
    case skill_attributes[:users_that_can_teach] do
      nil -> changeset
      _ -> Ecto.Changeset.put_assoc(changeset, :users_that_can_teach, skill_attributes[:users_that_can_teach])
    end
  end

  def load(id) do
    case Repo.get(Skill, id) do
      nil -> nil
      skill -> skill
      |> Repo.preload(:users_that_want_to_learn)
      |> Repo.preload(:users_that_can_teach)
    end
  end

  def list do
    from(s in Skill)
  end

  def load_all() do
    list
    |> preload(:users_that_want_to_learn)
    |> preload(:users_that_can_teach)
    |> Repo.all
  end

  def load_all(query) do
    query
    |> preload(:users_that_want_to_learn)
    |> preload(:users_that_can_teach)
    |> Repo.all
  end

  def delete(id) do
    case load(id) do
      nil -> {:not_found, id}
      skill ->  Repo.delete(skill)
    end
  end

  def count() do
    Repo.aggregate(Skill, :count, :id)
  end
end
