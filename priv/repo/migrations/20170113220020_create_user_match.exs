defmodule Matcher.Repo.Migrations.CreateUserMatch do
  use Ecto.Migration

  def change do
    create table(:user_matches) do
      add :status, :int, null: false
      add :teacher_id, references(:users, on_delete: :nothing)
      add :learner_id, references(:users, on_delete: :nothing)
      add :skill_id, references(:skills, on_delete: :nothing)

      timestamps()
    end

    create unique_index(:user_matches, [:teacher_id, :learner_id, :skill_id], name: :teacher_learner_skill_unique)

    create index(:user_matches, [:teacher_id])
    create index(:user_matches, [:learner_id])
    create index(:user_matches, [:skill_id])

  end
end
