defmodule FrontendWeb.NewAssignmentView do
  use FrontendWeb, :view

  def get_columns_list() do
    Db.Columns.get_columns()
    |> handle_empty_columns()
    |> Enum.map(&{&1.title, &1.id})
  end

  defp handle_empty_columns({0, nil} = _empty_map) do
    raise "Please run script to create columns"
  end

  defp handle_empty_columns(not_empty_map) do
    not_empty_map
  end

  def get_labels_list() do
    Db.Assignments.get_assignments()
    |> handle_empty_assignments()
    |> Enum.map(&{&1.title, &1.id})
  end
  
  defp handle_empty_assignments({0, nil} = _empty_map) do
    %{}
  end

  defp handle_empty_assignments(not_empty_map) do
    not_empty_map
  end
end
