defmodule InsuranceWeb.BrokerController do
  use InsuranceWeb, :controller
  alias Insurance.Quotes
  alias Insurance.Quotes.Quote

  def index(conn, _params) do
    render(conn, :index)
  end

  def show(conn, %{"name" => name}) do
    name = name
      |> String.replace("_", " ")
      |> capitalize_per_word

    quotes = Quotes.list_quotes_by_broker(name)

    render(conn, :show, quotes: quotes)
  end

  def capitalize_per_word(string) do
    String.split(string)
    |> Enum.map(&String.capitalize/1)
    |> Enum.join(" ")
  end

end
