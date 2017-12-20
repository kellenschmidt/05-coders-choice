defmodule FrontendWeb.Router do
  use FrontendWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", FrontendWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/new", NewAssignmentController, :index
    post "/new", NewAssignmentController, :create
    put "/new", NewAssignmentController, :update
    get "/list", AssignmentListController, :index
    get "/edit/:assignment_num", NewAssignmentController, :edit
    delete "/edit/:assignment_num", NewAssignmentController, :delete
    get "/labels", EditLabelsController, :index
    post "/labels", EditLabelsController, :create
    put "/labels", EditLabelsController, :update
    delete "/labels", EditLabelsController, :delete
  end

  # Other scopes may use custom stacks.
  # scope "/api", FrontendWeb do
  #   pipe_through :api
  # end
end
