defmodule Matchr.AppControllerTest do
  use Matchr.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"

    assert String.contains?(conn.resp_body, "Matchr")
  end
end
