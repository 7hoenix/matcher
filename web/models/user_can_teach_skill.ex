defmodule Matchr.UserCanTeachSkill do
  use Matchr.Web, :model

  schema "user_can_teach_skill" do
    belongs_to :user, Matchr.User
    belongs_to :skill, Matchr.Skill

    timestamps()
  end

  @required_attributes [
    :user_id,
    :skill_id,
  ]

  @optional_attributes []

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_attributes ++ @optional_attributes)
    |> validate_required(@required_attributes)
  end
end
