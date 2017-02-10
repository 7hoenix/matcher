defmodule Matchr.Skill do
  use Matchr.Web, :model

  schema "skills" do
    field :name, :string
    many_to_many :users_that_want_to_learn, Matchr.User, join_through: "user_wants_to_learn_skill", on_replace: :delete
    many_to_many :users_that_can_teach, Matchr.User, join_through: "user_can_teach_skill", on_replace: :delete
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
