defmodule Matchr.Support.Skills do
  alias Matchr.Skills

  def valid_skill_json do
    %{
      "name" => Faker.Pokemon.name,
    }
  end

  def valid_skill_attrs do
    %{
      name: Faker.Pokemon.name,
    }
  end

  def insert_skill(skill_attrs \\ %{}) do
    valid_skill_attrs
    |> Map.merge(skill_attrs)
    |> Skills.insert
  end
end
