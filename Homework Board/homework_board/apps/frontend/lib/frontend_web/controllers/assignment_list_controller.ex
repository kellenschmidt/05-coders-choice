defmodule FrontendWeb.AssignmentListController do
  use FrontendWeb, :controller

  def index(conn, _params) do
    conn
    |> render("index.html")
  end

end
