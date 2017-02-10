defmodule Matchr.Repo.Migrations.RemoveMetaDataFromUserToSkillAssociation do
  use Ecto.Migration

  def up do
    drop table(:user_skills)

    create table(:user_can_teach_skill) do
      add :user_id, references(:users)
      add :skill_id, references(:skills)
    end

    create table(:user_wants_to_learn_skill) do
      add :user_id, references(:users)
      add :skill_id, references(:skills)
    end
  end
  def down do
    drop table(:user_can_teach_skill)
    drop table(:user_wants_to_learn_skill)

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
