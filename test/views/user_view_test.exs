defmodule Matchr.UserViewTest do
  use Matchr.ConnCase, async: true
  import Matchr.Support.Users
  import Matchr.Support.Skills
  alias Matchr.UserView
  alias Matchr.Users
  alias Matchr.Skills

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
      {:ok, skill1} = insert_skill()
      {:ok, skill2} = insert_skill(%{name: "skill two"})
      {:ok, user} = insert_user(%{can_teach_skills: [skill1], wants_to_learn_skills: [skill2]})

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
