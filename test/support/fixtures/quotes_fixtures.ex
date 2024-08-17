defmodule Insurance.QuotesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Insurance.Quotes` context.
  """

  @doc """
  Generate a quote.
  """
  def quote_fixture(attrs \\ %{}) do
    {:ok, quote} =
      attrs
      |> Enum.into(%{
        account_name: "some account_name",
        average_premium: "some average_premium",
        broker_name: "some broker_name",
        brokerage_name: "some brokerage_name",
        quote_date: "some quote_date",
        person_email: "some person_email"
      })
      |> Insurance.Quotes.create_quote()

    quote
  end
end
