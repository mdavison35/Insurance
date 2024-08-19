defmodule InsuranceWeb.BrokerController do
  use InsuranceWeb, :controller
  alias Insurance.Quotes

  # Shows page with quotes matching broker parameter
  def show(conn, %{"name" => name}) do
    # change elxir_case to "Elixir Case" to match
    # database info
    name = name
      |> String.replace("_", " ")
      |> capitalize_per_word

    quotes = Quotes.list_quotes_by_broker(name)

    render(conn, :show, quotes: quotes)
  end

  # Capitalizes each word in a string
  defp capitalize_per_word(string) do
    String.split(string)
    |> Enum.map(&String.capitalize/1)
    |> Enum.join(" ")
  end

end
