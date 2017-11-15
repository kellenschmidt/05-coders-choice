defmodule Db.Repo.Migrations.CreateHomework do
  use Ecto.Migration

  def change do
    create table(:homework) do
      add :title, :string
      add :description, :string
      add :priority, :integer, default: 0
    end
  end
end
