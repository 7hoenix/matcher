defmodule Matchr.UserView do
  use Matchr.Web, :view

  def render("index.json", %{users: users}) do
    %{
      "data" => render_many(users, Matchr.UserView, "user.json")
    }
  end

  def render("show.json", %{user: user}) do
    %{
      "data" => render_one(user, Matchr.UserView, "user.json")
    }
  end

  def render("not_found.json", %{id: id}) do
    %{
      "errors" => [
        %{
          "status" => 404,
          "detail" => "User #{id} not found"
        }
      ]
    }
  end

  def render("delete.json", _) do
    %{}
  end

  def render("user.json", %{user: user}) do
    %{
      "id" => user.id,
      "name" => user.name,
    }
    |> put_can_teach_skills(user)
    |> put_wants_to_learn_skills(user)
  end

  def render("invalid.json", %{errors: errors}) do
    %{
      "errors" => Enum.map(errors, &render_validation_error/1)
    }
  end

  defp put_can_teach_skills(json, user) do
    case user.can_teach_skills do
      %Ecto.Association.NotLoaded{} -> json
      [] -> json
      skills -> Map.put(json, "canTeachSkills", render_many(skills, Matchr.SkillView, "skill.json"))
    end
  end

  defp put_wants_to_learn_skills(json, user) do
    case user.wants_to_learn_skills do
      %Ecto.Association.NotLoaded{} -> json
      [] -> json
      skills -> Map.put(json, "wantsToLearnSkills", render_many(skills, Matchr.SkillView, "skill.json"))
    end
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
