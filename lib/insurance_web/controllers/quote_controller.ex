defmodule InsuranceWeb.QuoteController do
  use InsuranceWeb, :controller

  alias Insurance.Quotes
  alias Insurance.Quotes.Quote

  def index(conn, _params) do
    quotes = Quotes.list_quotes(get_person_email(conn))
    render(conn, :index, quotes: quotes, person_email: get_person_email(conn))
  end

def get_person_email(conn) do
  case Map.has_key?(conn.assigns, :person) do
    false ->
      0
    true ->
      Map.get(conn.assigns.person, :email)
  end
end

  def new(conn, _params) do
    changeset = Quotes.change_quote(%Quote{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"quote" => quote_params}) do
    case Quotes.create_quote(quote_params) do
      {:ok, quote} ->
        conn
        |> put_flash(:info, "Quote created successfully.")
        |> redirect(to: ~p"/quotes/#{quote}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    quote = Quotes.get_quote!(id)
    broker_name = quote.broker_name
      |> String.replace(" ", "")
      |> Phoenix.Naming.underscore()
    render(conn, :show, quote: quote, broker_name: broker_name)
  end

  def edit(conn, %{"id" => id}) do
    quote = Quotes.get_quote!(id)
    changeset = Quotes.change_quote(quote)
    render(conn, :edit, quote: quote, changeset: changeset)
  end

  def update(conn, %{"id" => id, "quote" => quote_params}) do
    quote = Quotes.get_quote!(id)

    case Quotes.update_quote(quote, quote_params) do
      {:ok, quote} ->
        conn
        |> put_flash(:info, "Quote updated successfully.")
        |> redirect(to: ~p"/quotes/#{quote}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, quote: quote, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    quote = Quotes.get_quote!(id)
    {:ok, _quote} = Quotes.delete_quote(quote)

    conn
    |> put_flash(:info, "Quote deleted successfully.")
    |> redirect(to: ~p"/quotes")
  end
end
