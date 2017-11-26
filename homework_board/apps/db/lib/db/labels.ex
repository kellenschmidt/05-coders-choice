defmodule Db.Labels do
    use Ecto.Schema
    require Ecto.Query
  
    schema "labels" do
      field :title, :string
      field :color, :string
    end
  
    def changeset(label, params \\ %{}) do
      label
      |> Ecto.Changeset.cast(params, [:title, :color])
      |> Ecto.Changeset.validate_required([:title, :color])
    end
  
    def get_labels() do
      Db.Labels
      |> Db.Repo.all
    end
  
    def get_label(id) when is_integer(id) do
      Db.Labels
      |> Db.Repo.get(id)
    end
  
    def add_label(label) do
      Db.Labels.changeset(label)
      |> Db.Repo.insert()
      |> handle_query_response
    end

    def update_label(oldLabel, newLabel) do
      Db.Labels.changeset(oldLabel, newLabel)
      |> Db.Repo.update()
      |> handle_query_response
    end

    def delete_label(label) do
      Db.Repo.delete(label)
      |> handle_query_response
    end

    def delete_all() do
      Db.Labels
      |> Db.Repo.delete_all()
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
  