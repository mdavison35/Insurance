defmodule InsuranceWeb.BrokerControllerTest do
  use InsuranceWeb.ConnCase

  describe "index" do
    test "lists all quotes", %{conn: conn} do
      conn = get(conn, ~p"/broker/test")
      assert html_response(conn, 200) =~ "Listing Quotes"
    end
  end
end
