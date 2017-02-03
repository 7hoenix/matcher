defmodule Matchr.SkillViewTest do
  use Matchr.ConnCase, async: true
  alias Matchr.SkillView
  alias Matchr.Skills
  alias Matchr.Users
  alias Matchr.UserCanTeachSkills
  alias Matchr.UserWantsToLearnSkills

  def insert_skill(skill_attrs \\ %{}) do
    %{
      name: "skill name"
    }
    |> Map.merge(skill_attrs)
    |> Skills.insert
  end

  def insert_user(user_attrs \\ %{}) do
    %{
      name: "name"
    }
    |> Map.merge(user_attrs)
    |> Users.insert
  end

  describe "show" do
    test "renders a skill" do
      {:ok, skill} = insert_skill()

      rendered_skill = SkillView.render("show.json", skill: Skills.load(skill.id))

      assert rendered_skill == %{
        "data" => %{
          "id" => skill.id,
          "name" => skill.name,
        }
      }
    end

    test "renders a user with skills" do
      {:ok, skill} = insert_skill()
      {:ok, user1} = insert_user()
      {:ok, user2} = insert_user(%{name: "other"})
      {:ok, _} = UserCanTeachSkills.insert(%{user_id: user1.id, skill_id: skill.id})
      {:ok, _} = UserWantsToLearnSkills.insert(%{user_id: user2.id, skill_id: skill.id})

      rendered_skill = SkillView.render("show.json", skill: Skills.load(skill.id))

      assert rendered_skill == %{
        "data" => %{
          "id" => skill.id,
          "name" => skill.name,
          "usersThatCanTeach" => [
            %{
              "id" => user1.id,
              "name" => user1.name,
            }
          ],
        "usersThatWantToLearn" => [
          %{
            "id" => user2.id,
            "name" => user2.name,
          }
        ]
      }
    }
    end
  end

  describe "index" do
    test "renders a list of skills" do
      {:ok, skill1} = insert_skill()
      {:ok, skill2} = insert_skill(%{name: "other"})

      rendered_skills = SkillView.render("index.json", skills: Skills.load_all())

      assert rendered_skills == %{
        "data" => [
          %{
            "id" => skill1.id,
            "name" => skill1.name,
          },
          %{
            "id" => skill2.id,
            "name" => skill2.name,
          },
        ]
      }
    end
  end
end
