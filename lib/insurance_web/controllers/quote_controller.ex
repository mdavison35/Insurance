defmodule InsuranceWeb.QuoteController do
  use InsuranceWeb, :controller
  alias Insurance.Quotes
  alias Insurance.Quotes.Quote


  # Renders page showing quotes matching user's email
  def index(conn, _params) do
    quotes = Quotes.list_quotes_by_email(get_person_email(conn))
    render(conn, :index, quotes: quotes, person_email: get_person_email(conn))
  end

  # If user has logged in, adds their email to the conn struct
  def get_person_email(conn) do
    case Map.has_key?(conn.assigns, :person) do
      false ->
        0
      true ->
        Map.get(conn.assigns.person, :email)
    end
  end

  # Renders page to add a new quote
  def new(conn, _params) do
    changeset = Quotes.change_quote(%Quote{})
    render(conn, :new, changeset: changeset)
  end

  # Creates a new quote and redirects to showing quote list
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

  # Renders details for a specific quote
  def show(conn, %{"id" => id}) do
    quote = Quotes.get_quote!(id)

    # Puts broker_name into elixir case so it links to
    # that broker view correctly
    broker_name = quote.broker_name
      |> String.replace(" ", "")
      |> Phoenix.Naming.underscore()
    render(conn, :show, quote: quote, broker_name: broker_name)
  end

  # Shows page to edit a quote
  def edit(conn, %{"id" => id}) do
    quote = Quotes.get_quote!(id)
    changeset = Quotes.change_quote(quote)
    render(conn, :edit, quote: quote, changeset: changeset)
  end

  # Updates a specified quote from the edit page
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

  # Deletes a specified quote from the database
  def delete(conn, %{"id" => id}) do
    quote = Quotes.get_quote!(id)
    {:ok, _quote} = Quotes.delete_quote(quote)

    conn
    |> put_flash(:info, "Quote deleted successfully.")
    |> redirect(to: ~p"/quotes")
  end
end
