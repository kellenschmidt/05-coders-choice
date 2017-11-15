defmodule WebWeb.PageController do
  use WebWeb, :controller

  def index(conn, _params) do
    %{ title: title } = Db.Assignments.get_assignment(1)
    
    conn
    |> assign(:titleVar, title)
    |> render "index.html"
  end
end
