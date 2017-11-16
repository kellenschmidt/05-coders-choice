defmodule Db.Assignments do
  use Ecto.Schema
  require Ecto.Query

  schema "assignments" do
    field :title, :string
    field :description, :string
    field :priority, :integer
  end

  def changeset(assignment, params \\ %{}) do
    assignment
    |> Ecto.Changeset.cast(params, [:title, :description, :priority])
    |> Ecto.Changeset.validate_required([:title])
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
    changeset = Db.Assignments.changeset(assignment, %{})
    Db.Repo.insert(changeset)
    |> handle_query_response
  end

  def get_all_with_priority(priority) when is_integer(priority) do
    Db.Assignments
    |> Ecto.Query.where(priority: ^priority)
    |> Db.Repo.all
  end

  def update_assignment(assignment, newAssignment) do
    changeset = Db.Assignments.changeset(assignment, newAssignment)
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
  defp handle_query_response({ :error, changeset } = _response) do
    # Is raising an error proper in this situation?
    errors = Ecto.Changeset.traverse_errors(changeset, fn {msg, opts} ->
      Enum.reduce(opts, msg, fn {key, value}, acc ->
        String.replace(acc, "%{#{key}}", to_string(value))
      end)
    end)

    raise ("Error modifying database: #{inspect errors}")
  end

end
