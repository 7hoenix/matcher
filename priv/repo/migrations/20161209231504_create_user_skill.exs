defmodule Matchr.Repo.Migrations.CreateUserSkill do
  use Ecto.Migration

  def change do
    create table(:user_skills) do
      add :can_teach, :boolean, null: false
      add :active, :boolean, default: true, null: false
      add :user_id, references(:users, on_delete: :nothing)
      add :skill_id, references(:skills, on_delete: :nothing)

      timestamps()
    end
    create index(:user_skills, [:user_id])
    create index(:user_skills, [:skill_id])

  end
end
