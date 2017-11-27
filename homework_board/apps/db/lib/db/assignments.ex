defmodule Db.Assignments do
  use Ecto.Schema
  require Ecto.Query

  schema "assignments" do
    field :title, :string
    field :description, :string
    field :priority, :integer
    field :column_id, :integer
    field :labels, {:array, :integer}
    field :due_date, :naive_datetime
  end

  def changeset(assignment, params \\ %{}) do
    assignment
    |> Ecto.Changeset.cast(params, [:title, :description, :priority, :column_id, :labels, :due_date])
    |> Ecto.Changeset.validate_required([:title, :column_id])
  end

  def get_assignments() do
    Db.Assignments
    |> Db.Repo.all
  end

  def get_assignment(id) when is_integer(id) do
    Db.Assignments
    |> Db.Repo.get(id)
  end

  def add_assignment(assignment) do
    Db.Assignments.changeset(assignment)
    |> Db.Repo.insert()
    |> handle_query_response
  end

  def get_all_with_priority(priority) when is_integer(priority) do
    Db.Assignments
    |> Ecto.Query.where(priority: ^priority)
    |> Db.Repo.all
  end

  def get_assignments_for_column(column_id) when is_integer(column_id) do
    Db.Assignments
    |> Ecto.Query.where(column_id: ^column_id)
    |> Db.Repo.all
  end

  def update_assignment(oldAssignment, newAssignment) do
    Db.Assignments.changeset(oldAssignment, newAssignment)
    |> Db.Repo.update()
    |> handle_query_response
  end

  def delete_assignment(assignment) do
    Db.Repo.delete(assignment)
    |> handle_query_response
  end

  defp handle_query_response({ :ok, _changeset } = _response) do
    IO.puts "Successfully modified database"
  end
  defp handle_query_response({ :error, changeset } = _response) do
    errors = Ecto.Changeset.traverse_errors(changeset, fn {msg, opts} ->
      Enum.reduce(opts, msg, fn {key, value}, acc ->
        String.replace(acc, "%{#{key}}", to_string(value))
      end)
    end)

    raise ("Error modifying database: #{inspect errors}")
  end

end
