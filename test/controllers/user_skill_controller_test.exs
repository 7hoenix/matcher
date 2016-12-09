defmodule Matchr.UserSkillControllerTest do
  use Matchr.ConnCase

  alias Matchr.UserSkill
  @valid_attrs %{active: true, knowledgable: true}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, user_skill_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    user_skill = Repo.insert! %UserSkill{}
    conn = get conn, user_skill_path(conn, :show, user_skill)
    assert json_response(conn, 200)["data"] == %{"id" => user_skill.id,
      "user_id" => user_skill.user_id,
      "skill_id" => user_skill.skill_id,
      "knowledgable" => user_skill.knowledgable,
      "active" => user_skill.active}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, user_skill_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, user_skill_path(conn, :create), user_skill: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(UserSkill, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, user_skill_path(conn, :create), user_skill: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    user_skill = Repo.insert! %UserSkill{}
    conn = put conn, user_skill_path(conn, :update, user_skill), user_skill: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(UserSkill, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    user_skill = Repo.insert! %UserSkill{}
    conn = put conn, user_skill_path(conn, :update, user_skill), user_skill: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    user_skill = Repo.insert! %UserSkill{}
    conn = delete conn, user_skill_path(conn, :delete, user_skill)
    assert response(conn, 204)
    refute Repo.get(UserSkill, user_skill.id)
  end
end
