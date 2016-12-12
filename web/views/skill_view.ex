defmodule Matcher.SkillView do
  use Matcher.Web, :view

  def render("index.json", %{skills: skills}) do
    %{data: render_many(skills, Matcher.SkillView, "skill.json")}
  end

  def render("show.json", %{skill: skill}) do
    %{data: render_one(skill, Matcher.SkillView, "skill.json")}
  end

  def render("skill.json", %{skill: skill}) do
    %{id: skill.id,
      name: skill.name}
  end
end
