defmodule Matchr.SkillView do
  use Matchr.Web, :view

  def render("index.json", %{skills: skills}) do
    %{
      "data" => render_many(skills, Matchr.SkillView, "skill.json")
    }
  end

  def render("show.json", %{skill: skill}) do
    %{
      "data" => render_one(skill, Matchr.SkillView, "skill.json")
    }
  end


  def render("not_found.json", %{id: id}) do
    %{
      "errors" => [
        %{
          "status" => 404,
          "detail" => "Skill #{id} not found"
        }
      ]
    }
  end

  def render("delete.json", _) do
    %{}
  end

  def render("skill.json", %{skill: skill}) do
    %{
      "id" => skill.id,
      "name" => skill.name,
    }
    |> put_users_that_can_teach(skill)
    |> put_users_that_want_to_learn(skill)
  end

  defp put_users_that_can_teach(json, skill) do
    case skill.users_that_can_teach do
      %Ecto.Association.NotLoaded{} -> json
      [] -> json
      users -> Map.put(json, "usersThatCanTeach", render_many(users, Matchr.UserView, "user.json"))
    end
  end

  defp put_users_that_want_to_learn(json, skill) do
    case skill.users_that_want_to_learn do
      %Ecto.Association.NotLoaded{} -> json
      [] -> json
      users -> Map.put(json, "usersThatWantToLearn", render_many(users, Matchr.UserView, "user.json"))
    end
  end

  def render("invalid.json", %{errors: errors}) do
    %{
      "errors" => Enum.map(errors, &render_validation_error/1)
    }
  end

  defp render_validation_error({field, {message, _}}) do
    %{
      "status" => 422,
      "source" => source(field),
      "detail" => message,
    }
  end

  defp source(field) do
    case field do
      :name -> "name"
      _ -> field
    end
  end
end
