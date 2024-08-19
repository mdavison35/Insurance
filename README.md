# Insurance
### MDavison Capstone Project for CS-499

## Installation
In order to run this project, you will need to follow the installition instructions for Phoenix framework found 
[here](https://hexdocs.pm/phoenix/installation.html).

Then in the terminal cd into the folder for the project and:
  * Run `mix setup` to setup dependencies
  * Run `mix deps.get` to install dependencies
  * Run `mix ecto.create` to create the database
  * Run `mix ecto.migrate` to run the database migration
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Authentication
 * Visit [authdemo.fly.dev](authdemo.fly.dev)
 * Sign in using GitHub or Google
 * Create the app with localhost:4000 as the URL
 * Save and copy the export AUTH_API_KEY=... key
 * create a new .env file in the project directory
 * paste the export AUTH_API_KEY=... into the .env file
 * add the .env file to .gitignore
 * run `source .env` in the project directory

## Data
The sample_data.csv file can be used to test the import feature and populate data

## Acknowledgements

  * The CSV importing feature using liveview was adapted from [FullstackPhoenix](https://fullstackphoenix.com/tutorials/import-csv-with-preview-liveview-file-upload)

