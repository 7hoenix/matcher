defmodule Matchr.UserSkillView do
  use Matchr.Web, :view

  def render("index.json", %{user_skills: user_skills}) do
    %{data: render_many(user_skills, Matchr.UserSkillView, "user_skill.json")}
  end

  def render("show.json", %{user_skill: user_skill}) do
    %{data: render_one(user_skill, Matchr.UserSkillView, "user_skill.json")}
  end

  def render("user_skill.json", %{user_skill: user_skill}) do
    %{id: user_skill.id,
      user_id: user_skill.user_id,
      skill_id: user_skill.skill_id,
      knowledgable: user_skill.knowledgable,
      active: user_skill.active}
  end
end
