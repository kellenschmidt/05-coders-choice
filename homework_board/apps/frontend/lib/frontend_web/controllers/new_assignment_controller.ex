defmodule FrontendWeb.NewAssignmentController do
  use FrontendWeb, :controller

  def index(conn, _params) do
    changeset = Db.Assignments.changeset(%Db.Assignments{})
    conn
    |> assign(:changeset, changeset)
    |> render("index.html")
  end

  def create(conn, %{"assignments" => %{"title" => title, "priority" => priority_str}} = _params) do
    {priority, _} = Integer.parse(priority_str)

    %Db.Assignments{title: title, priority: priority}
    |> Db.Assignments.add_assignment()

    index(conn, %{})
  end

end
