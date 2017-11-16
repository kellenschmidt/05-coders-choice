defmodule Db.Repo.Migrations.CreateAssignments do
  use Ecto.Migration

  def change do
    create table(:assignments) do
      add :title, :string
      add :description, :string, default: ""
      add :priority, :integer, default: 0
    end
  end
end
