defmodule Matcher.UserSkillView do
  use Matcher.Web, :view

  def render("user_skill.json", %{user_skill: user_skill}) do
    %{id: user_skill.id}
  end
end
