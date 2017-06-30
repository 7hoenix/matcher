defmodule Matchr.UserController do
  use Matchr.Web, :controller

  alias Matchr.Users

  def index(conn, _params) do
    users = Users.load_all
    render(conn, "index.json", users: users)
  end

  def show(conn, %{"id" => id}) do
    case Users.load(id) do
      nil -> conn |> put_status(404) |> render("not_found.json", id: id)
      user -> render(conn, "show.json", user: user)
    end
  end

  def create(conn, params) do
    case Users.insert(user_data(params)) do
      {:ok, user} ->
        conn
        |> put_status(201)
        |> render("show.json", user: Users.load(user.id))
      {:error, changeset} ->
        conn
        |> put_status(422)
        |> render("invalid.json", errors: changeset.errors)
    end
  end

  def update(conn, params) do
    id = params["id"]
    case Users.update(id, user_data(params)) do
      {:ok, user} ->
        conn
        |> put_status(200)
        |> render("show.json", user: Users.load(user.id))
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
    case Users.delete(id) do
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

  defp user_data(params) do
    %{
      name: params["user"]["name"],
    }
  end
end
