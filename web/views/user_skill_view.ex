defmodule Matcher.UserSkillView do
  use Matcher.Web, :view

  def render("user_skill.json", %{user_skill: user_skill}) do
    %{id: user_skill.id,
      skill_name: user_skill.skill_name}
  end
end
