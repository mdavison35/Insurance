defmodule InsuranceWeb.QuoteController do
  use InsuranceWeb, :controller

  alias Insurance.Quotes
  alias Insurance.Quotes.Quote

  def index(conn, _params) do
    quotes = Quotes.list_quotes()
    render(conn, :index, quotes: quotes)
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
    render(conn, :show, quote: quote)
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
