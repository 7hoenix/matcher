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
    |> put_teachers(skill)
    |> put_learners(skill)
  end

  defp put_teachers(json, skill) do
    case skill.teachers do
      %Ecto.Association.NotLoaded{} -> json
      [] -> json
      users -> Map.put(json, "usersThatCanTeach", render_many(users, Matchr.UserView, "user.json"))
    end
  end

  defp put_learners(json, skill) do
    case skill.learners do
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
