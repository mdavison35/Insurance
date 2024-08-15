defmodule InsuranceWeb.BrokerageController do
  use InsuranceWeb, :controller
  alias Insurance.Quotes
  alias Insurance.Quotes.Quote

  def show(conn, %{"name" => name}) do
    name = name
      |> String.replace("_", " ")


    quotes = Quotes.list_quotes_by_brokerage(name)

    render(conn, :show, quotes: quotes)
  end

end
