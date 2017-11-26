defmodule FrontendWeb.EditLabelsController do
  use FrontendWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
