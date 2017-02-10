defmodule Matchr.Users do
  use Matchr.Repo
  alias Matchr.User

  def insert(user_attributes) do
    User.changeset(%User{}, user_attributes)
    |> assoc_skills(user_attributes)
    |> Repo.insert
  end

  def update(id, user_attributes) do
    case load(id) do
      nil -> {:not_found, id}
      user ->
        User.changeset(user, user_attributes)
        |> assoc_skills(user_attributes)
        |> Repo.update
    end
  end

  defp assoc_skills(changeset, user_attributes) do
   changeset
    |> assoc_wants_to_learn_skills(user_attributes)
    |> assoc_can_teach_skills(user_attributes)
  end

  defp assoc_wants_to_learn_skills(changeset, user_attributes) do
    case user_attributes[:wants_to_learn_skills] do
      nil -> changeset
      _ -> Ecto.Changeset.put_assoc(changeset, :wants_to_learn_skills, user_attributes[:wants_to_learn_skills])
    end
  end

  defp assoc_can_teach_skills(changeset, user_attributes) do
    case user_attributes[:can_teach_skills] do
      nil -> changeset
      _ -> Ecto.Changeset.put_assoc(changeset, :can_teach_skills, user_attributes[:can_teach_skills])
    end
  end

  def load(id) do
    case Repo.get(User, id) do
      nil -> nil
      user -> user
      |> Repo.preload(:wants_to_learn_skills)
      |> Repo.preload(:can_teach_skills)
    end
  end

  def list do
    from(u in User)
  end

  def load_all() do
    list
    |> preload(:wants_to_learn_skills)
    |> preload(:can_teach_skills)
    |> Repo.all
  end

  def load_all(query) do
    query
    |> preload(:wants_to_learn_skills)
    |> preload(:can_teach_skills)
    |> Repo.all
  end

  def delete(id) do
    case load(id) do
      nil -> {:not_found, id}
      user ->  Repo.delete(user)
    end
  end

  def count() do
    Repo.aggregate(User, :count, :id)
  end
end
