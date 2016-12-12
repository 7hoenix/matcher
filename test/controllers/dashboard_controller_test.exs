defmodule Matcher.DashboardControllerTest do
  use Matcher.ConnCase

  alias Matcher.Repo
  alias Matcher.User
  alias Matcher.Skill
  alias Matcher.UserSkill

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists no skills when user has none associated", %{conn: conn} do
    user = Repo.insert!(%User{name: "Lovelace"})
    conn = get conn, dashboard_path(conn, :dashboard, %{user_id: user.id})
    assert json_response(conn, 200)["data"] == []
  end

  test "list skills associated with a user", %{conn: conn} do
    user = Repo.insert!(%User{name: "Lovelace"})
    skill1 = Repo.insert!(%Skill{name: "sketch"})
    skill2 = Repo.insert!(%Skill{name: "elixir"})
    user_skill1 = Repo.insert!(%UserSkill{user_id: user.id, skill_id: skill1.id, can_teach: true})
    user_skill2 = Repo.insert!(%UserSkill{user_id: user.id, skill_id: skill2.id, can_teach: false})
    conn = get conn, dashboard_path(conn, :dashboard, %{user_id: user.id})
    assert json_response(conn, 200)["data"] == [
      %{"id" => user_skill1.id, "skill_name" => skill1.name},
      %{"id" => user_skill2.id, "skill_name" => skill2.name}
    ]
  end
end
