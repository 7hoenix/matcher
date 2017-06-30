defmodule Matchr.SkillViewTest do
  use Matchr.ConnCase, async: true
  import Matchr.Support.Users
  import Matchr.Support.Skills
  alias Matchr.SkillView
  alias Matchr.Skills
  alias Matchr.Users


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

    test "renders a skill with users" do
      {:ok, user1} = insert_user()
      {:ok, user2} = insert_user(%{name: "other"})
      {:ok, skill} = insert_skill(%{teachers: [user1], learners: [user2]})

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
