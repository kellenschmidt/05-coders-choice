defmodule Db.Homework do
  use Ecto.Schema

  schema "homework" do
    field :title, :string
    field :description, :string
    field :priority, :integer
  end
end
