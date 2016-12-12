defmodule Matcher.UserSkill do
  use Matcher.Web, :model

  schema "user_skills" do
    field :can_teach, :boolean
    field :active, :boolean, default: true
    belongs_to :user, Matcher.User
    belongs_to :skill, Matcher.Skill

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:can_teach, :active])
    |> validate_required([:can_teach, :active])
  end
end
