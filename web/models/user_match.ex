defmodule Matcher.UserMatch do
  use Matcher.Web, :model

  alias Matcher.User
  alias Matcher.Skill

  schema "user_matches" do
    field :status, :integer
    belongs_to :learner, User
    belongs_to :teacher, User
    belongs_to :skill, Skill

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:status])
    |> validate_required([:status])
  end
end
