defmodule FrontendWeb.NewAssignmentController do
  use FrontendWeb, :controller

  def index(conn, _params) do
    changeset = Db.Assignments.changeset(%Db.Assignments{})
    conn
    |> assign(:changeset, changeset)
    |> render("index.html")
  end

  def create(conn, %{"assignments" => %{"title" => title, "description" => description, "priority" => priority_str}} = _params) do
    {priority, _} = Integer.parse(priority_str)

    new_assignment = %Db.Assignments{}
    |> Map.put(:title, title)
    |> Map.put(:description, description)
    |> Map.put(:priority, priority)
    |> Db.Assignments.add_assignment()

    index(conn, %{})
  end

end
