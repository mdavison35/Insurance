defmodule InsuranceWeb.BrokerageControllerTest do
  use InsuranceWeb.ConnCase

  import Insurance.QuotesFixtures

  @create_attrs %{account_name: "some account_name", broker_name: "some broker_name", brokerage_name: "some brokerage_name", quote_date: "some quote_date", average_premium: "some average_premium", person_email: "some person_email"}
  @update_attrs %{account_name: "some updated account_name", broker_name: "some updated broker_name", brokerage_name: "some updated brokerage_name", quote_date: "some updated quote_date", average_premium: "some updated average_premium", person_email: "some updated person_email"}
  @invalid_attrs %{account_name: nil, broker_name: nil, brokerage_name: nil, quote_date: nil, average_premium: nil, person_email: nil}

  describe "index" do
    test "lists all quotes", %{conn: conn} do
      conn = get(conn, ~p"/brokerage/test")
      assert html_response(conn, 200) =~ "Listing Quotes"
    end
  end
end
