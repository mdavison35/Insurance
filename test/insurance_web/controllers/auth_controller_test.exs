defmodule InsuranceWeb.AuthControllerTest do
  use InsuranceWeb.ConnCase

  test "GET /login", %{conn: conn} do
    conn = get(conn, ~p"/login")
    assert html_response(conn, 302) =~ "You are being"
  end

  test "GET /logout", %{conn: conn} do
    conn = get(conn, ~p"/logout")
    assert assert html_response(conn, 302) =~ "Welcome!"
  end
end
