defmodule Db.Homework do
  use Ecto.Schema
  require Ecto.Query

  schema "homework" do
    field :title, :string
    field :description, :string
    field :priority, :integer
  end

  def changeset(homework, params \\ %{}) do
    homework
    |> Ecto.Changeset.cast(params, [:title, :description, :priority])
    |> Ecto.Changeset.validate_required([:title, :description, :priority])
  end

  def get_homework() do
    Db.Homework
    |> Db.Repo.all
  end

  def get_homework(id) when is_integer(id) do
    Db.Homework
    |> Db.Repo.get(id)
  end

  def add_homework(homework) do
    changeset = Db.Homework.changeset(homework, %{})
    Db.Repo.insert(changeset)
    |> handle_query_response
  end

  def get_all_with_priority(priority) when is_integer(priority) do
    Db.Homework |> Ecto.Query.where(priority: ^priority) |> Db.Repo.all
  end

  def update_homework(homework, newHomework) do
    changeset = Db.Homework.changeset(homework, newHomework)
    Db.Repo.update(changeset)
    |> handle_query_response
  end

  def delete_homework(homework) do
    Db.Repo.delete(homework)
    |> handle_query_response
  end

  defp handle_query_response({ :ok, _changeset } = _response) do
    IO.puts "Successfully modified database"
  end
  defp handle_query_response({ :error, _changeset } = _response) do
    # Is raising an error proper in this situatuon?
    raise "Error modifying database"
  end

end
