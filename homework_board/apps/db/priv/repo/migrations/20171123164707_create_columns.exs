defmodule Db.Repo.Migrations.CreateColumns do
  use Ecto.Migration

  def change do
    create table(:columns) do
      add :title, :string
      add :sort_order, :integer
      add :color, :string, default: "primary"
    end
  end
end
