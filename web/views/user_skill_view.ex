defmodule Matcher.UserSkillView do
  use Matcher.Web, :view

  def render("index.json", %{user_skills: user_skills}) do
    %{data: render_many(user_skills, Matcher.UserSkillView, "user_skill.json")}
  end

  def render("show.json", %{user_skill: user_skill}) do
    %{data: render_one(user_skill, Matcher.UserSkillView, "user_skill.json")}
  end

  def render("user_skill.json", %{user_skill: user_skill}) do
    %{id: user_skill.id,
      user_id: user_skill.user_id,
      skill_id: user_skill.skill_id,
      can_teach: user_skill.can_teach,
      active: user_skill.active}
  end
end
