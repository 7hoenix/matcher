defmodule Matcher.Skill do
  use Matcher.Web, :model

  schema "skills" do
    field :name, :string
    has_many :user_skills, Matcher.UserSkill
    has_many :user_matches, Matcher.UserMatch

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name])
    |> validate_required([:name])
  end
end
