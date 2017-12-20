defmodule FrontendWeb.EditLabelsController do
  use FrontendWeb, :controller

  def index(conn, _params) do
    changeset = Db.Labels.changeset(%Db.Labels{})
    conn
    |> assign(:changeset, changeset)
    |> render("index.html")
  end

  def create(conn, %{"labels" => labels_param} = _params) do
    formatted_map = labels_param
    |> Map.delete("id")
    |> format_map_with_ints()
    

    Map.merge(%Db.Labels{}, formatted_map)
    |> Db.Labels.add_label()

    conn
    |> index([])
  end

  def update(conn, %{"labels" => labels_param} = _params) do
    updated_label = labels_param
    |> format_map_with_ints()
    
    Db.Labels.get_label(updated_label.id)
    |> Db.Labels.update_label(updated_label)

    conn
    |> index([])
  end

  def delete(conn, _params) do    
    Db.Labels.delete_all()

    conn
    |> index([])
  end

  defp map_keys_from_string_to_atom(%{} = map_param) do
    map_param
    |> Enum.reduce(%{}, fn ({key, val}, acc) -> Map.put(acc, String.to_atom(key), val) end)
  end

  defp string_to_int(string_param) when is_bitstring(string_param) do
    {int_representation, _} = Integer.parse(string_param)
    int_representation
  end

  defp format_map_with_ints(%{"id" => id_str} = label_map) do
    label_map
    |> to_int_and_add_to_map("id", id_str)
    |> map_keys_from_string_to_atom()
  end

  defp format_map_with_ints(%{} = label_map) do
    label_map
    |> map_keys_from_string_to_atom()
  end

  defp to_int_and_add_to_map(map, key, value_str) do
    value_as_int = value_str
    |> string_to_int()

    map
    |> Map.put(key, value_as_int)
  end
end
