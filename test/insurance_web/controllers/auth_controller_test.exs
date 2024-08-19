defmodule InsuranceWeb.AuthControllerTest do
  use InsuranceWeb.ConnCase

  test "GET /login", %{conn: conn} do
    conn = get(conn, ~p"/login")
    assert html_response(conn, 302) =~ "You are being"
  end
end
