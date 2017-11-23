defmodule FrontendWeb.NewAssignmentController do
  use FrontendWeb, :controller

  def index(conn, _params) do
    changeset = Db.Assignments.changeset(%Db.Assignments{})
    conn
    |> assign(:changeset, changeset)
    |> render("index.html")
  end

  def edit(conn, %{"assignment_num" => assignment_num} = params) do
    
    changeset = Db.Assignments.get_assignment(assignment_num)
    |> Db.Assignments.changeset()

    conn
    |> assign(:changeset, changeset)
    |> render("index.html")
  end

  def create(conn, %{"assignments" => assignment_param} = params) do
    map_with_atoms = assignment_param
    |> map_keys_from_string_to_atom()
    
    priority_as_str = map_with_atoms.priority
    |> string_to_int()
    
    Map.merge(%Db.Assignments{}, map_with_atoms)
    |> Map.put(:priority, priority_as_str)
    |> Db.Assignments.add_assignment()

    conn
    |> render(FrontendWeb.AssignmentListView, "index.html")
  end

  defp map_keys_from_string_to_atom(%{} = map_param) do
    map_param
    |> Enum.reduce(%{}, fn ({key, val}, acc) -> Map.put(acc, String.to_atom(key), val) end)
  end

  defp string_to_int(string_param) when is_bitstring(string_param) do
    {int_representation, _} = Integer.parse(string_param)
    int_representation
  end

end
