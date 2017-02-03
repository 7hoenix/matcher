defmodule Matcher.UserSkill do
  use Matcher.Web, :model

  alias Matcher.User
  alias Matcher.Skill

  schema "user_skills" do
    field :can_teach, :boolean
    field :active, :boolean, default: true
    belongs_to :user, User
    belongs_to :skill, Skill

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:can_teach, :active])
    |> validate_required([:can_teach, :active])
  end
end
