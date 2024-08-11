defmodule InsuranceWeb.QuoteControllerTest do
  use InsuranceWeb.ConnCase

  import Insurance.QuotesFixtures

  @create_attrs %{account_name: "some account_name", broker_name: "some broker_name", brokerage_name: "some brokerage_name", quote_date: "some quote_date", average_premium: "some average_premium"}
  @update_attrs %{account_name: "some updated account_name", broker_name: "some updated broker_name", brokerage_name: "some updated brokerage_name", quote_date: "some updated quote_date", average_premium: "some updated average_premium"}
  @invalid_attrs %{account_name: nil, broker_name: nil, brokerage_name: nil, quote_date: nil, average_premium: nil}

  describe "index" do
    test "lists all quotes", %{conn: conn} do
      conn = get(conn, ~p"/quotes")
      assert html_response(conn, 200) =~ "Listing Quotes"
    end
  end

  describe "new quote" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/quotes/new")
      assert html_response(conn, 200) =~ "New Quote"
    end
  end

  describe "create quote" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/quotes", quote: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/quotes/#{id}"

      conn = get(conn, ~p"/quotes/#{id}")
      assert html_response(conn, 200) =~ "Quote #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/quotes", quote: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Quote"
    end
  end

  describe "edit quote" do
    setup [:create_quote]

    test "renders form for editing chosen quote", %{conn: conn, quote: quote} do
      conn = get(conn, ~p"/quotes/#{quote}/edit")
      assert html_response(conn, 200) =~ "Edit Quote"
    end
  end

  describe "update quote" do
    setup [:create_quote]

    test "redirects when data is valid", %{conn: conn, quote: quote} do
      conn = put(conn, ~p"/quotes/#{quote}", quote: @update_attrs)
      assert redirected_to(conn) == ~p"/quotes/#{quote}"

      conn = get(conn, ~p"/quotes/#{quote}")
      assert html_response(conn, 200) =~ "some updated account_name"
    end

    test "renders errors when data is invalid", %{conn: conn, quote: quote} do
      conn = put(conn, ~p"/quotes/#{quote}", quote: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Quote"
    end
  end

  describe "delete quote" do
    setup [:create_quote]

    test "deletes chosen quote", %{conn: conn, quote: quote} do
      conn = delete(conn, ~p"/quotes/#{quote}")
      assert redirected_to(conn) == ~p"/quotes"

      assert_error_sent 404, fn ->
        get(conn, ~p"/quotes/#{quote}")
      end
    end
  end

  defp create_quote(_) do
    quote = quote_fixture()
    %{quote: quote}
  end
end
