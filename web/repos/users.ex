defmodule Matchr.Users do
  use Matchr.Repo
  alias Matchr.User

  def insert(user_attributes) do
    User.changeset(%User{}, user_attributes)
    |> Repo.insert
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

  def update(id, user_attributes) do
    case load(id) do
      nil -> {:not_found, id}
      user ->
        User.changeset(user, user_attributes)
        |> Repo.update
    end
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
