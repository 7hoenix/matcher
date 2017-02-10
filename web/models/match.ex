defmodule Matchr.Match do
  use Matchr.Web, :model

  schema "matches" do
    field :teacher_id, :integer
    field :learner_id, :integer
    field :skill_id, :integer
    timestamps()
  end

  @required_attributes [
   :teacher_id,
   :learner_id,
   :skill_id
  ]

  @optional_attributes []

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_attributes ++ @optional_attributes)
    |> validate_required(@required_attributes)
  end
end
