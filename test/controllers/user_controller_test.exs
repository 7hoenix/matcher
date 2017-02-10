defmodule Matchr.UserControllerTest do
  use Matchr.ConnCase

  alias Matchr.Users
  alias Matchr.UserView

  @user_json %{
    "name" => "jon"
  }

  @skill_json %{
    "name" => "skill name"
  }

  describe "create" do
    test "creates a valid user", %{conn: conn} do
      conn = conn |> post("/api/users", %{"user" => @user_json})

      assert conn.status == 201
      assert Users.count == 1
    end

    test "returns errors for invalid user params", %{conn: conn} do
      conn = conn |> post("/api/users", %{"user" => %{"name" => nil}})

      assert conn.status == 422
      assert Users.count == 0
      assert json_response(conn, 422) == %{
        "errors" => [
          %{
            "status" => 422,
            "source" => "name",
            "detail" => "can't be blank",
          }
        ]
      }
    end
  end

  describe "index" do
    defp user_index(user) do
      UserView.render("user.json", user: (Users.load(user.id)))
    end

    test"renders a list of users", %{conn: conn} do
      {:ok, user1} = Users.insert(%{name: "John"})
      {:ok, user2} = Users.insert(%{name: "Jane"})

      conn = conn |> get("/api/users")

      assert json_response(conn, 200) == %{
        "data" => [
          user_index(user1),
          user_index(user2),
        ]
      }
    end
  end

  describe "show" do
    test "renders a user", %{conn: conn} do
      {:ok, user} = Users.insert(%{name: "John"})

      conn = conn |> get("/api/users/#{user.id}")

      assert json_response(conn, 200) == %{
        "data" => user_index(user)
        }
    end

    test "returns not found for invalid user id", %{conn: conn} do
      conn = conn |> get("/api/users/999")

      assert json_response(conn, 404) == %{
        "errors" => [
          %{
            "status" => 404,
            "detail" => "User 999 not found",
          }
        ]
      }

    end
  end
  describe "update" do
    test "updates a valid user", %{conn: conn} do
      {:ok, user} = Users.insert(%{name: "John"})

      conn = conn |> put("/api/users/#{user.id}", %{"user" => %{"name" => "new"}})

      assert conn.status == 200
      assert Users.count == 1
      assert Users.load(user.id).name == "new"
    end

    test "retruns 404 for invalid user id", %{conn: conn} do

      conn = conn |> put("/api/users/999", %{"user" => %{"name" => "new"}})

      assert conn.status == 404
    end

    test "returns 422 for invalid json", %{conn: conn} do
      {:ok, user} = Users.insert(%{name: "John"})

      conn = conn |> put("/api/users/#{user.id}", %{"user" => %{"name" => nil}})

      assert conn.status == 422
    end
  end

  describe "delete" do
    test "removes a user when that id exists", %{conn: conn} do
      {:ok, user} = Users.insert(%{name: "John"})

      conn = conn |> delete("/api/users/#{user.id}")

      assert conn.status == 200
      assert Users.count == 0
    end

    test "returns 404 when trying to a user id that doesn't exist", %{conn: conn} do
      conn = conn |> delete("/api/users/999")

      assert conn.status == 404
    end
  end
end
