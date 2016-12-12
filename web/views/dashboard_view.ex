defmodule Matcher.DashboardView do
  use Matcher.Web, :view

  def render("dashboard.json", %{user_skills: user_skills}) do
    %{data: render_many(user_skills, Matcher.UserSkillView, "user_skill.json")}
  end
end
