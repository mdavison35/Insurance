defmodule Insurance.Quotes.Quote do
  use Ecto.Schema
  import Ecto.Changeset

  schema "quotes" do
    field :account_name, :string
    field :broker_name, :string
    field :brokerage_name, :string
    field :quote_date, :string
    field :average_premium, :string
    field :person_email, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(quote, attrs) do
    quote
    |> cast(attrs, [:account_name, :broker_name, :brokerage_name, :quote_date, :average_premium, :person_email])
    |> validate_required([:account_name, :broker_name, :brokerage_name, :quote_date, :average_premium, :person_email])
  end
end
