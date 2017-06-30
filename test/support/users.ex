defmodule Matchr.Support.Users do
  alias Matchr.Users

  def valid_user_json do
    %{
      "name" => Faker.Name.first_name,
      "email" => Faker.Internet.email,
      "google_oid" => Faker.Internet.user_name,
    }
  end

  def valid_user_attrs() do
    %{
      name: Faker.Name.first_name,
      email: Faker.Internet.email,
      google_oid: Faker.Internet.user_name,
    }
  end

  def insert_user(user_attributes \\ %{}) do
    valid_user_attrs
    |> Map.merge(user_attributes)
    |> Users.insert
  end
end
