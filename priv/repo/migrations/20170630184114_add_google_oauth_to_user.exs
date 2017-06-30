defmodule Matchr.Repo.Migrations.AddGoogleOauthToUser do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :email, :string, null: false
      add :google_oid, :string, null: false
      add :google_refresh_token, :string
    end

    create unique_index :users, :email
    create unique_index :users, :google_oid
  end
end
