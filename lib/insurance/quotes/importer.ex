defmodule Insurance.Quotes.Importer do
  alias Insurance.Quotes
  alias Insurance.Quotes.Quote

  def preview(rows) do
    rows
    |> Enum.take(6)
    |> transform_keys()
    |> Enum.map(fn attrs ->
      Quotes.change_quote(%Quote{}, attrs)
      |> Ecto.Changeset.apply_changes()
    end)
  end

  def import(rows) do
    rows
    |> transform_keys()
    |> Enum.map(fn attrs ->
      Quotes.create_quote(attrs)
    end)
  end

  def import(rows, email) do
    rows
    |> transform_keys()
    |> Enum.map(fn attrs ->
      Quotes.create_quote(attrs, email)
    end)
  end

  # "Account Name" => "account_name"
  defp transform_keys(rows) do
    rows
    |> Enum.map(fn row ->
      Enum.reduce(row, %{}, fn {key, val}, map ->
        Map.put(map, underscore_key(key), val)
      end)
    end)
  end

  # removes space for elixir/phoenix underscore notation
  defp underscore_key(key) do
    key
    |> String.replace(" ", "")
    |> Phoenix.Naming.underscore()
  end
end
