defmodule Matchr.UserSkill do
  use Matchr.Web, :model

  schema "user_skills" do
    field :knowledgable, :boolean, default: false
    field :active, :boolean, default: false
    belongs_to :user, Matchr.User
    belongs_to :skill, Matchr.Skill

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:knowledgable, :active])
    |> validate_required([:knowledgable, :active])
  end
end
