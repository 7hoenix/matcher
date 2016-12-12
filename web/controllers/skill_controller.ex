defmodule Matcher.SkillController do
  use Matcher.Web, :controller

  alias Matcher.Skill

  def index(conn, _params) do
    skills = Repo.all(Skill)
    render(conn, "index.json", skills: skills)
  end
end
