defmodule Matcher.SkillControllerTest do
  use Matcher.ConnCase

  alias Matcher.Skill

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  # test "returns an empty list when no skills are present", %{conn: conn} do
  #   conn = get conn, skill_path(conn, :index)
  #   assert json_response(conn, 200)["data"] == []
  # end

  # test "returns a list with skills when skills are present", %{conn: conn} do
  #   skill1 = Repo.insert!(%Skill{name: "sketch"})
  #   skill2 = Repo.insert!(%Skill{name: "clojure"})
  #   skill3 = Repo.insert!(%Skill{name: "elixir"})
  #   conn = get conn, skill_path(conn, :index)
  #   assert json_response(conn, 200)["data"] == [
  #     %{"id" => skill1.id, "name" => skill1.name},
  #     %{"id" => skill2.id, "name" => skill2.name},
  #     %{"id" => skill3.id, "name" => skill3.name}
  #   ]
  # end
end
