defmodule Matchr.UserViewTest do
  use Matchr.ConnCase, async: true
  alias Matchr.UserView
  alias Matchr.Users
  alias Matchr.Skills
  alias Matchr.UserCanTeachSkills
  alias Matchr.UserWantsToLearnSkills

  def insert_user(user_attrs \\ %{}) do
    %{
      name: "name"
    }
    |> Map.merge(user_attrs)
    |> Users.insert
  end

  def insert_skill(skill_attrs \\ %{}) do
    %{
      name: "skill name"
    }
    |> Map.merge(skill_attrs)
    |> Skills.insert
  end

  @valid_user_skill_attrs %{
    user_id: 1,
    skill_id: 1,
  }

  describe "show" do
    test "renders a user" do
      {:ok, user} = insert_user()

      rendered_user = UserView.render("show.json", user: Users.load(user.id))

      assert rendered_user == %{
        "data" => %{
          "id" => user.id,
          "name" => user.name,
        }
      }
    end

    test "renders a user with skills" do
      {:ok, user} = insert_user()
      {:ok, skill1} = insert_skill()
      {:ok, skill2} = insert_skill(%{name: "skill two"})
      {:ok, _} = UserCanTeachSkills.insert(%{@valid_user_skill_attrs | user_id: user.id, skill_id: skill1.id})
      {:ok, _} = UserWantsToLearnSkills.insert(%{@valid_user_skill_attrs | user_id: user.id, skill_id: skill2.id})


      rendered_user = UserView.render("show.json", user: Users.load(user.id))

      assert rendered_user == %{
        "data" => %{
          "id" => user.id,
          "name" => user.name,
          "canTeachSkills" => [
            %{
              "id" => skill1.id,
              "name" => skill1.name,
            }
            ],
          "wantsToLearnSkills" => [
            %{
              "id" => skill2.id,
              "name" => skill2.name,
            }
          ]
        }
      }
    end
  end

  describe "index" do
    test "renders a list of users" do
      {:ok, user1} = insert_user()
      {:ok, user2} = insert_user(%{name: "other"})

      rendered_users = UserView.render("index.json", users: Users.load_all())

      assert rendered_users == %{
        "data" => [
          %{
            "id" => user1.id,
            "name" => user1.name,
          },
          %{
            "id" => user2.id,
            "name" => user2.name,
          },
        ]
      }
    end
  end
end
