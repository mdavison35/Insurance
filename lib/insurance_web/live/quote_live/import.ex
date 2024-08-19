defmodule InsuranceWeb.QuoteLive.Import do
  use InsuranceWeb, :live_view
  alias Insurance.Quotes.Importer

  # Mounts the liveview session and sets socket variables
  @impl true
  def mount(%{"email" => email}, _session, socket) do
    {:ok,
    socket
    |> assign(:email, email)
    |> assign(:parsed_rows, [])
    |> assign(:imported_quotes, [])
    |> assign(:sample_quotes, [])
    |> assign(:uploaded_files, [])
    |> allow_upload(:sample_csv, accept: ~w(.csv), max_entries: 1)}

  end

  # Upon user clicking the reset button, socket variables are
  # set to blank lists, except :email which stays as the user email
  @impl true
  def handle_event("reset", _, socket) do
    {
      :noreply,
      socket
      |> assign(:parsed_rows, [])
      |> assign(:imported_quotes, [])
      |> assign(:sample_quotes, [])
      |> assign(:uploaded_files, [])
    }
  end

  # Validates socket
  def handle_event("validate", _params, socket) do
    {:noreply, socket}
  end

  # Reads data from uploaded .csv file
  def handle_event("parse", _, socket) do
    parsed_rows = parse_csv(socket)
    {
      :noreply,
      socket
      |> assign(:parsed_rows, parsed_rows)
      |> assign(:sample_quotes, Importer.preview(parsed_rows))
      |> assign(:uploaded_files, [])
    }
  end

  # Imports loaded data from the .csv into the database
  def handle_event("import", _, socket) do
    imported_quotes = Importer.import(socket.assigns.parsed_rows, socket.assigns.email)
    {
      :noreply,
      socket
      |> assign(:sample_quotes, [])
      |> assign(:imported_quotes, imported_quotes)
    }
  end

  # Helper function to parse .csv into an elixir list
  defp parse_csv(socket) do
    consume_uploaded_entries(socket, :sample_csv, fn %{path: path}, _entry ->
      rows =
        path
        |> File.stream!()
        |> CSV.decode!(headers: true)
        |> Enum.to_list()

      {:ok, rows}
    end)
    |> List.flatten()
  end
end
