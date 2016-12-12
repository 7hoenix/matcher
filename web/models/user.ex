defmodule Matcher.User do
  use Matcher.Web, :model

  schema "users" do
    field :name, :string
    has_many :user_skills, Matcher.UserSkill

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
