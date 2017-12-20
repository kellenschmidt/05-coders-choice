defmodule Db.Repo.Migrations.CreateAssignments do
  use Ecto.Migration

  def change do
    create table(:assignments) do
      add :title, :string
      add :description, :string, default: ""
      add :column_id, :integer
      add :labels, {:array, :integer}
      add :due_date, :naive_datetime
    end
  end
end
