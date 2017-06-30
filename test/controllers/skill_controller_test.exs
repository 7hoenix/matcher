defmodule Matchr.SkillControllerTest do
  use Matchr.ConnCase
  import Matchr.Support.Skills
  alias Matchr.Skills
  alias Matchr.SkillView

  describe "create" do
    test "creates a valid skill", %{conn: conn} do
      conn = conn |> post("/api/skills", %{"skill" => valid_skill_json})

      assert conn.status == 201
      assert Skills.count == 1
    end

    test "returns errors for invalid skill params", %{conn: conn} do
      conn = conn |> post("/api/skills", %{"skill" => %{"name" => nil}})

      assert conn.status == 422
      assert Skills.count == 0
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
    defp skill_index(skill) do
      SkillView.render("skill.json", skill: (Skills.load(skill.id)))
    end

    test"renders a list of skills", %{conn: conn} do
      {:ok, skill1} = Skills.insert(%{name: "John"})
      {:ok, skill2} = Skills.insert(%{name: "Jane"})

      conn = conn |> get("/api/skills")

      assert json_response(conn, 200) == %{
        "data" => [
          skill_index(skill1),
          skill_index(skill2),
        ]
      }
    end
  end

  describe "show" do
    test "renders a skill", %{conn: conn} do
      {:ok, skill} = Skills.insert(%{name: "John"})

      conn = conn |> get("/api/skills/#{skill.id}")

      assert json_response(conn, 200) == %{
        "data" => skill_index(skill)
        }
    end

    test "returns not found for invalid skill id", %{conn: conn} do
      conn = conn |> get("/api/skills/999")

      assert json_response(conn, 404) == %{
        "errors" => [
          %{
            "status" => 404,
            "detail" => "Skill 999 not found",
          }
        ]
      }

    end
  end

  describe "update" do
    test "updates a valid skill", %{conn: conn} do
      {:ok, skill} = Skills.insert(%{name: "John"})

      conn = conn |> put("/api/skills/#{skill.id}", %{"skill" => %{"name" => "new"}})

      assert conn.status == 200
      assert Skills.count == 1
      assert Skills.load(skill.id).name == "new"
    end

    test "retruns 404 for invalid skill id", %{conn: conn} do

      conn = conn |> put("/api/skills/999", %{"skill" => %{"name" => "new"}})

      assert conn.status == 404
    end

    test "returns 422 for invalid json", %{conn: conn} do
      {:ok, skill} = Skills.insert(%{name: "John"})

      conn = conn |> put("/api/skills/#{skill.id}", %{"skill" => %{"name" => nil}})

      assert conn.status == 422
    end
  end

  describe "delete" do
    test "removes a skill when that id exists", %{conn: conn} do
      {:ok, skill} = Skills.insert(%{name: "John"})

      conn = conn |> delete("/api/skills/#{skill.id}")

      assert conn.status == 200
      assert Skills.count == 0
    end

    test "returns 404 when trying to a skill id that doesn't exist", %{conn: conn} do
      conn = conn |> delete("/api/skills/999")

      assert conn.status == 404
    end
  end
end
