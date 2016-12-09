defmodule Matchr.SkillControllerTest do
  use Matchr.ConnCase

  alias Matchr.Skill
  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, skill_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    skill = Repo.insert! %Skill{}
    conn = get conn, skill_path(conn, :show, skill)
    assert json_response(conn, 200)["data"] == %{"id" => skill.id,
      "name" => skill.name}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, skill_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, skill_path(conn, :create), skill: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Skill, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, skill_path(conn, :create), skill: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    skill = Repo.insert! %Skill{}
    conn = put conn, skill_path(conn, :update, skill), skill: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Skill, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    skill = Repo.insert! %Skill{}
    conn = put conn, skill_path(conn, :update, skill), skill: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    skill = Repo.insert! %Skill{}
    conn = delete conn, skill_path(conn, :delete, skill)
    assert response(conn, 204)
    refute Repo.get(Skill, skill.id)
  end
end
