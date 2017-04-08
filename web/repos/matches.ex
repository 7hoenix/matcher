defmodule Matchr.Matches do
  use Matchr.Repo
  alias Matchr.Match

  def insert(match_attributes) do
    Match.changeset(%Match{}, match_attributes)
    |> Repo.insert
  end

  def count do
    Repo.aggregate(Match, :count, :id)
  end

  def load(id) do
    Repo.get(Match, id)
  end

  def load_all do
    from(m in Match)
    |> Repo.all
  end
end
