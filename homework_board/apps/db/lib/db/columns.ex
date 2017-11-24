defmodule Db.Columns do
    use Ecto.Schema
    require Ecto.Query
  
    schema "columns" do
      field :title, :string
      field :sort_order, :integer
      field :color, :string
    end
  
    def changeset(assignment, params \\ %{}) do
      assignment
      |> Ecto.Changeset.cast(params, [:title, :sort_order])
      |> Ecto.Changeset.validate_required([:title, :sort_order])
    end
  
    def get_columns() do
      Db.Columns
      |> Db.Repo.all
    end
  
    def get_columns(id) when is_integer(id) do
      Db.Columns
      |> Db.Repo.get(id)
    end
  
    def add_column(column) do
      Db.Columns.changeset(column)
      |> Db.Repo.insert()
      |> handle_query_response
    end
  
    # def get_all_with_priority(priority) when is_integer(priority) do
    #   Db.Assignments
    #   |> Ecto.Query.where(priority: ^priority)
    #   |> Db.Repo.all
    # end
  
    def update_column(oldColumn, newColumn) do
      Db.Assignments.changeset(oldColumn, newColumn)
      |> Db.Repo.update()
      |> handle_query_response
    end

    def delete_column(column) do
      Db.Repo.delete(column)
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
  