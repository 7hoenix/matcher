defmodule Matchr.User do
  use Matchr.Web, :model

  schema "users" do
    field :name, :string
    field :email, :string
    field :google_oid, :string
    field :google_refresh_token, :string
    many_to_many :wants_to_learn_skills, Matchr.Skill, join_through: "user_wants_to_learn_skill", on_replace: :delete
    many_to_many :can_teach_skills, Matchr.Skill, join_through: "user_can_teach_skill", on_replace: :delete
    timestamps()
  end

  @required_attributes [
    :name,
  ]

  @optional_attributes [
    :email,
    :google_oid,
    :google_refresh_token,
  ]

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_attributes ++ @optional_attributes)
    |> validate_required(@required_attributes)
  end
end
