defmodule Insurance.Quotes do
  @moduledoc """
  The Quotes context.
  """

  import Ecto.Query, warn: false
  alias Insurance.Repo
  alias Insurance.Quotes
  alias Insurance.Quotes.Quote

  @doc """
  Returns the list of quotes.

  ## Examples

      iex> list_quotes()
      [%Quote{}, ...]

  """
  def list_quotes_by_email(person_email \\ "") do
    #Quote |> Ecto.Query.where(broker_name: "Jared Mertz") |> Repo.all()
    if is_integer(person_email) do
      query =
        from(
          q in Quote,
          select: q,
          where: q.person_email == "",
          order_by: [desc: :quote_date]
        )
      Repo.all(query)
    else
    query =
      from(
        q in Quote,
        select: q,
        where: q.person_email == ^person_email,
        order_by: [desc: :quote_date]
      )
    Repo.all(query)
    #Quote |> Ecto.Query.order_by(desc: :average_premium) |> Repo.all()
    #Repo.all(Quote
    end
  end

  def list_quotes() do
    query =
      from(
        q in Quote,
        select: q,
        order_by: [desc: :quote_date]
      )
    Repo.all(query)
  end

  def list_quotes_by_broker(broker_name) do
    query =
      from(
        q in Quote,
        select: q,
        where: q.broker_name == ^broker_name,
        order_by: [desc: :quote_date]
      )
    Repo.all(query)
    #Quote |> Ecto.Query.where() |> Repo.all()
  end

  def list_quotes_by_brokerage(brokerage_name) do
    query =
      from(
        q in Quote,
        select: q,
        where: q.brokerage_name == ^brokerage_name,
        order_by: [desc: :quote_date]
      )
    Repo.all(query)
    #Quote |> Ecto.Query.where(brokerage_name: ^brokerage_name) |> Repo.all()
  end

  @doc """
  Gets a single quote.

  Raises `Ecto.NoResultsError` if the Quote does not exist.

  ## Examples

      iex> get_quote!(123)
      %Quote{}

      iex> get_quote!(456)
      ** (Ecto.NoResultsError)

  """
  def get_quote!(id), do: Repo.get!(Quote, id)

  @doc """
  Creates a quote.

  ## Examples

      iex> create_quote(%{field: value})
      {:ok, %Quote{}}

      iex> create_quote(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  # def create_quote(attrs) do
  #  %Quote{}
  #  |> Quote.changeset(attrs)
  #  |> Repo.insert()
  #end

  def create_quote_email(attrs \\ %{}, email) do
    attrs = Attrs.put(attrs, :person_email, email)
    create_quote(attrs)
  end

  def create_quote(attrs \\ %{}) do
    %Quote{}
    |> Quote.changeset(attrs)
    |> Repo.insert()
  end


  @doc """
  Updates a quote.

  ## Examples

      iex> update_quote(quote, %{field: new_value})
      {:ok, %Quote{}}

      iex> update_quote(quote, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_quote(%Quote{} = quote, attrs) do
    quote
    |> Quote.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a quote.

  ## Examples

      iex> delete_quote(quote)
      {:ok, %Quote{}}

      iex> delete_quote(quote)
      {:error, %Ecto.Changeset{}}

  """
  def delete_quote(%Quote{} = quote) do
    Repo.delete(quote)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking quote changes.

  ## Examples

      iex> change_quote(quote)
      %Ecto.Changeset{data: %Quote{}}

  """
  def change_quote(%Quote{} = quote, attrs \\ %{}) do
    Quote.changeset(quote, attrs)
  end
end
