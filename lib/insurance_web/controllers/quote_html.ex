defmodule InsuranceWeb.QuoteHTML do
  use InsuranceWeb, :html

  embed_templates "quote_html/*"

  @doc """
  Renders a quote form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def quote_form(assigns)
end
