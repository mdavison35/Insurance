defmodule Insurance.QuotesTest do
  use Insurance.DataCase

  alias Insurance.Quotes

  describe "quotes" do
    alias Insurance.Quotes.Quote

    import Insurance.QuotesFixtures

    @invalid_attrs %{account_name: nil, broker_name: nil, brokerage_name: nil, quote_date: nil, average_premium: nil, person_email: nil}

    test "list_quotes/0 returns all quotes" do
      quote = quote_fixture()
      assert Quotes.list_quotes() == [quote]
    end

    test "list_quotes_by_email/1 returns matching quotes" do
      quote = quote_fixture()
      assert Quotes.list_quotes_by_email("some person_email") == [quote]
    end

    test "list_quotes_by_broker/1 returns matching quotes" do
      quote = quote_fixture()
      assert Quotes.list_quotes_by_broker("some broker_name") == [quote]
    end

    test "list_quotes_by_brokerage/1 returns matching quotes" do
      quote = quote_fixture()
      assert Quotes.list_quotes_by_brokerage("some brokerage_name") == [quote]
    end

    test "get_quote!/1 returns the quote with given id" do
      quote = quote_fixture()
      assert Quotes.get_quote!(quote.id) == quote
    end

    test "create_quote/1 with valid data creates a quote" do
      valid_attrs = %{account_name: "some account_name", broker_name: "some broker_name",
                       brokerage_name: "some brokerage_name", quote_date: "some quote_date",
                       average_premium: "some average_premium", person_email: "some person_email"}

      assert {:ok, %Quote{} = quote} = Quotes.create_quote(valid_attrs)
      assert quote.account_name == "some account_name"
      assert quote.broker_name == "some broker_name"
      assert quote.brokerage_name == "some brokerage_name"
      assert quote.quote_date == "some quote_date"
      assert quote.average_premium == "some average_premium"
      assert quote.person_email == "some person_email"
    end

    test "create_quote_email/2 with valid data creates a quote" do
      valid_attrs = %{account_name: "some account_name", broker_name: "some broker_name",
                       brokerage_name: "some brokerage_name", quote_date: "some quote_date",
                       average_premium: "some average_premium"}

      assert {:ok, %Quote{} = quote} = Quotes.create_quote_email(valid_attrs, "some person_email")
      assert quote.account_name == "some account_name"
      assert quote.broker_name == "some broker_name"
      assert quote.brokerage_name == "some brokerage_name"
      assert quote.quote_date == "some quote_date"
      assert quote.average_premium == "some average_premium"
      assert quote.person_email == "some person_email"
    end

    test "create_quote/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Quotes.create_quote(@invalid_attrs)
    end

    test "update_quote/2 with valid data updates the quote" do
      quote = quote_fixture()
      update_attrs = %{account_name: "some updated account_name", broker_name: "some updated broker_name",
                        brokerage_name: "some updated brokerage_name", quote_date: "some updated quote_date",
                        average_premium: "some updated average_premium", person_email: "some updated person_email"}

      assert {:ok, %Quote{} = quote} = Quotes.update_quote(quote, update_attrs)
      assert quote.account_name == "some updated account_name"
      assert quote.broker_name == "some updated broker_name"
      assert quote.brokerage_name == "some updated brokerage_name"
      assert quote.quote_date == "some updated quote_date"
      assert quote.average_premium == "some updated average_premium"
      assert quote.person_email == "some updated person_email"
    end

    test "update_quote/2 with invalid data returns error changeset" do
      quote = quote_fixture()
      assert {:error, %Ecto.Changeset{}} = Quotes.update_quote(quote, @invalid_attrs)
      assert quote == Quotes.get_quote!(quote.id)
    end

    test "delete_quote/1 deletes the quote" do
      quote = quote_fixture()
      assert {:ok, %Quote{}} = Quotes.delete_quote(quote)
      assert_raise Ecto.NoResultsError, fn -> Quotes.get_quote!(quote.id) end
    end

    test "change_quote/1 returns a quote changeset" do
      quote = quote_fixture()
      assert %Ecto.Changeset{} = Quotes.change_quote(quote)
    end
  end
end
