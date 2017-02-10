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
    |> assoc_learners(skill_attributes)
    |> assoc_teachers(skill_attributes)
  end

  defp assoc_learners(changeset, skill_attributes) do
    case skill_attributes[:learners] do
      nil -> changeset
      _ -> Ecto.Changeset.put_assoc(changeset, :learners, skill_attributes[:learners])
    end
  end

  defp assoc_teachers(changeset, skill_attributes) do
    case skill_attributes[:teachers] do
      nil -> changeset
      _ -> Ecto.Changeset.put_assoc(changeset, :teachers, skill_attributes[:teachers])
    end
  end

  def load(id) do
    case Repo.get(Skill, id) do
      nil -> nil
      skill -> skill
      |> Repo.preload(:learners)
      |> Repo.preload(:teachers)
    end
  end

  def list do
    from(s in Skill)
  end

  def load_all() do
    list
    |> preload(:learners)
    |> preload(:teachers)
    |> Repo.all
  end

  def load_all(query) do
    query
    |> preload(:learners)
    |> preload(:teachers)
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
