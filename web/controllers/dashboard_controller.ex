defmodule Matcher.DashboardController do
  use Matcher.Web, :controller
  import Ecto.Query

  alias Matcher.Repo
  alias Matcher.Skill
  alias Matcher.UserSkill

  def dashboard(conn, %{"user_id" => user_id}) do
    user_skills = Repo.all(from user_skill in UserSkill,
     join: skill in assoc(user_skill, :skill),
     where: user_skill.user_id == ^user_id,
     where: skill.id == user_skill.skill_id,
     select: %{id: user_skill.id, skill_name: skill.name})
    render(conn, "dashboard.json", %{user_skills: user_skills})
  end
end
