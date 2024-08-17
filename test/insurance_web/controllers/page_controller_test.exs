defmodule InsuranceWeb.PageControllerTest do
  use InsuranceWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, ~p"/")
    assert html_response(conn, 200) =~ "Welcome!"
  end

  test "connected mount", %{conn: conn} do
    conn = get(conn, ~p"/quotes/import/email")
    assert html_response(conn, 200) =~ "Import Quotes"
  end
end
