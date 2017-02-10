defmodule Matchr.User do
  use Matchr.Web, :model

  schema "users" do
    field :name, :string
    many_to_many :wants_to_learn_skills, Matchr.Skill, join_through: "user_wants_to_learn_skill", on_replace: :delete
    many_to_many :can_teach_skills, Matchr.Skill, join_through: "user_can_teach_skill", on_replace: :delete
    timestamps()
  end

  @required_attributes [
    :name,
  ]

  @optional_attributes []

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_attributes ++ @optional_attributes)
    |> validate_required(@required_attributes)
  end
end
