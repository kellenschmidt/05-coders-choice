defmodule Db.Assignment do
  use Ecto.Schema
  require Ecto.Query

  schema "assignment" do
    field :title, :string
    field :description, :string
    field :priority, :integer
  end

  def changeset(assignment, params \\ %{}) do
    assignment
    |> Ecto.Changeset.cast(params, [:title, :description, :priority])
    |> Ecto.Changeset.validate_required([:title, :description, :priority])
  end

  def get_assignment() do
    Db.Assignment
    |> Db.Repo.all
  end

  def get_assignment(id) when is_integer(id) do
    Db.Assignment
    |> Db.Repo.get(id)
  end

  def add_assignment(assignment) do
    changeset = Db.Assignment.changeset(assignment, %{})
    Db.Repo.insert(changeset)
    |> handle_query_response
  end

  def get_all_with_priority(priority) when is_integer(priority) do
    Db.Assignment |> Ecto.Query.where(priority: ^priority) |> Db.Repo.all
  end

  def update_assignment(assignment, newAssignment) do
    changeset = Db.Assignment.changeset(assignment, newAssignment)
    Db.Repo.update(changeset)
    |> handle_query_response
  end

  def delete_assignment(assignment) do
    Db.Repo.delete(assignment)
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
