defmodule Db.Repo.Migrations.CreateLabels do
  use Ecto.Migration

  def change do
    create table(:labels) do
      add :title, :string
      add :color, :string, default: "primary"
    end
  end
end
