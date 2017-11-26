defmodule FrontendWeb.EditLabelsView do
  use FrontendWeb, :view

  def get_labels() do
    Db.Labels.get_labels()
  end

  def get_labels_list() do
    get_labels()
    |> handle_empty_labels()
    |> Enum.map(&{&1.title, &1.id})
  end
  
  defp handle_empty_labels({0, nil} = _empty_map) do
    %{}
  end

  defp handle_empty_labels(not_empty_map) do
    not_empty_map
  end

  def get_color(%Db.Labels{color: color}) do
    color
  end

  def get_title(%Db.Labels{title: title}) do
    title
  end

  def get_changeset_for_label(%Db.Labels{id: id} = _label) do
    Db.Labels.get_label(id)
    |> Db.Labels.changeset()
  end

  def get_colors() do
    []
    |> List.insert_at(0, %{disp_name: "White", bs_color: "light"})
    |> List.insert_at(0, %{disp_name: "Gray", bs_color: "secondary"})
    |> List.insert_at(0, %{disp_name: "Black", bs_color: "dark"})
    |> List.insert_at(0, %{disp_name: "Teal", bs_color: "info"})
    |> List.insert_at(0, %{disp_name: "Orange", bs_color: "warning"})
    |> List.insert_at(0, %{disp_name: "Red", bs_color: "danger"})
    |> List.insert_at(0, %{disp_name: "Green", bs_color: "success"})
    |> List.insert_at(0, %{disp_name: "Blue", bs_color: "primary"})    
  end

end
