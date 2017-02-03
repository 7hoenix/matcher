defmodule Matchr.SkillController do
  use Matchr.Web, :controller

  alias Matchr.Skills

  def index(conn, _params) do
    skills = Skills.load_all
    render(conn, "index.json", skills: skills)
  end

  def show(conn, %{"id" => id}) do
    case Skills.load(id) do
      nil -> conn |> put_status(404) |> render("not_found.json", id: id)
      skill -> render(conn, "show.json", skill: skill)
    end
  end

  def create(conn, params) do
    case Skills.insert(skill_data(params)) do
      {:ok, skill} ->
        conn
        |> put_status(201)
        |> render("show.json", skill: Skills.load(skill.id))
      {:error, changeset} ->
        conn
        |> put_status(422)
        |> render("invalid.json", errors: changeset.errors)
    end
  end

  def update(conn, params) do
    id = params["id"]
    case Skills.update(id, skill_data(params)) do
      {:ok, skill} ->
        conn
        |> put_status(200)
        |> render("show.json", skill: Skills.load(skill.id))
      {:not_found, id} ->
        conn
        |> put_status(404)
        |> render("not_found.json", id: id)
      {:error, changeset} ->
        conn
        |> put_status(422)
        |> render("invalid.json", errors: changeset.errors)
    end
  end

  def delete(conn, params) do
    id = params["id"]
    case Skills.delete(id) do
      {:ok, _} ->
        conn
        |> put_status(200)
        |> render("delete.json")
      {:not_found, id} ->
        conn
        |> put_status(404)
        |> render("not_found.json", id: id)
    end
  end

  defp skill_data(params) do
    %{
      name: params["skill"]["name"]
    }
  end
end
