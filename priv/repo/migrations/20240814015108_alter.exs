defmodule Insurance.Repo.Migrations.Alter do
  use Ecto.Migration

  def change do
    create table(:quotes) do
      add :account_name, :string
      add :broker_name, :string
      add :brokerage_name, :string
      add :quote_date, :string
      add :average_premium, :string
      add :person_email, :string

      timestamps(type: :utc_datetime)
    end
  end
end
