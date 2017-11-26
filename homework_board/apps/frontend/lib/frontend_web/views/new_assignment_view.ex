defmodule FrontendWeb.NewAssignmentView do
  use FrontendWeb, :view

  def get_labels() do
    Db.Labels.get_labels()
  end

  def get_columns() do
    Db.Columns.get_columns()
  end

  def get_columns_list() do
    get_columns()
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
    get_labels()
    |> handle_empty_labels()
    |> Enum.map(&{&1.title, &1.id})
  end
  
  defp handle_empty_labels({0, nil} = _empty_map) do
    [ %{title: "No labels created yet", id: -1} ]
  end

  defp handle_empty_labels(not_empty_map) do
    not_empty_map
  end

  def is_disabled() do
    get_labels()
    |> are_labels_empty()
  end

  defp are_labels_empty({0, nil} = _empty_map) do
    true
  end
  defp are_labels_empty(_not_empty_map) do
    false
  end

end
