defmodule Matchr.Repo.Migrations.CreateMatchTable do
  use Ecto.Migration

  def change do
    create table(:matches) do
      add :teacher_id, :integer, null: false
      add :learner_id, :integer, null: false
      add :skill_id, :integer, null: false

      timestamps()
    end
  end
end
