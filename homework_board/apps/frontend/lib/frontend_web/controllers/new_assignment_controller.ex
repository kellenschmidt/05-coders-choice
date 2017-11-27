defmodule FrontendWeb.NewAssignmentController do
  use FrontendWeb, :controller

  def index(conn, _params) do
    changeset = Db.Assignments.changeset(%Db.Assignments{})
    conn
    |> assign(:changeset, changeset)
    |> render("index.html")
  end

  def edit(conn, %{"assignment_num" => assignment_num} = _params) do
    changeset = assignment_num
    |> to_int()
    |> Db.Assignments.get_assignment()
    |> Db.Assignments.changeset()

    conn
    |> assign(:changeset, changeset)
    |> render("index.html")
  end

  def create(conn, %{"assignments" => assignment_param} = _params) do
    formatted_map = assignment_param
    |> Map.delete("id")
    |> format_map_with_ints()
    |> format_date()

    Map.merge(%Db.Assignments{}, formatted_map)
    |> Db.Assignments.add_assignment()

    conn
    |> render(FrontendWeb.AssignmentListView, "index.html")
  end

  def update(conn, %{"assignments" => assignment_param} = _params) do
    updated_assignment = assignment_param
    |> format_map_with_ints()
    |> format_date()
    
    Db.Assignments.get_assignment(updated_assignment.id)
    |> Db.Assignments.update_assignment(updated_assignment)

    conn
    |> render(FrontendWeb.AssignmentListView, "index.html")
  end

  defp map_keys_from_string_to_atom(%{} = map_param) do
    map_param
    |> Enum.reduce(%{}, fn ({key, val}, acc) -> Map.put(acc, String.to_atom(key), val) end)
  end

  defp format_map_with_ints(%{"id" => id_str, "priority" => priority_str, "column_id" => column_id_str, "labels" => labels_str_list} = assignment_map) do
    assignment_map
    |> to_int_and_add_to_map("id", id_str)
    |> to_int_and_add_to_map("priority", priority_str)
    |> to_int_and_add_to_map("column_id", column_id_str)
    |> to_int_and_add_to_map("labels", labels_str_list)
    |> map_keys_from_string_to_atom()
  end

  defp format_map_with_ints(%{"id" => id_str, "priority" => priority_str, "column_id" => column_id_str} = assignment_map) do
    assignment_map
    |> to_int_and_add_to_map("id", id_str)
    |> to_int_and_add_to_map("priority", priority_str)
    |> to_int_and_add_to_map("column_id", column_id_str)
    |> map_keys_from_string_to_atom()
  end

  defp format_map_with_ints(%{"priority" => priority_str, "column_id" => column_id_str, "labels" => labels_str_list} = assignment_map) do
    assignment_map
    |> to_int_and_add_to_map("priority", priority_str)
    |> to_int_and_add_to_map("column_id", column_id_str)
    |> to_int_and_add_to_map("labels", labels_str_list)
    |> map_keys_from_string_to_atom()
  end

  defp format_map_with_ints(%{"priority" => priority_str, "column_id" => column_id_str} = assignment_map) do
    assignment_map
    |> to_int_and_add_to_map("priority", priority_str)
    |> to_int_and_add_to_map("column_id", column_id_str)
    |> map_keys_from_string_to_atom()
  end

  defp to_int_and_add_to_map(map, key, value_str) do
    value_as_int = value_str
    |> to_int()

    map
    |> Map.put(key, value_as_int)
  end

  defp to_int(string_param) when is_bitstring(string_param) do
    {int_representation, _} = Integer.parse(string_param)
    int_representation
  end

  defp to_int(list_param) when is_list(list_param) do
    list_param
    |> Enum.map(&to_int/1)
  end

  defp to_int(map_param) when is_map(map_param) do
    map_param
    |> Enum.reduce(%{}, fn ({key, val}, acc) -> Map.put(acc, key, to_int(val)) end)
  end

  defp create_naive_datetime(%{} = datetime_param) do
    %{year: year, month: month, day: day, hour: hour, minute: minute} = datetime_param
    |> map_keys_from_string_to_atom()
    |> to_int()

    {:ok, naive_datetime} = NaiveDateTime.new(year, month, day, hour, minute, 0)
    naive_datetime
  end

  defp format_date(%{due_date: date_map} = assignment_param) do
    naive_datetime = date_map
    |> create_naive_datetime()

    assignment_param
    |> Map.put(:due_date, naive_datetime)
  end

end
