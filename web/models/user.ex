defmodule Matchr.User do
  use Matchr.Web, :model

  schema "users" do
    field :name, :string
    has_many :user_skills, Matchr.UserSkill

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name])
    |> validate_required([:name])
  end
end