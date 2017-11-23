defmodule FrontendWeb.AssignmentListView do
  use FrontendWeb, :view

  def assignment_list() do
    Db.Assignments.get_assignments()
    |> IO.inspect
  end

  def columns() do
    [ %{header: "Upcoming", background: "primary"},
      %{header: "In progress", background: "success"},
      %{header: "Completed", background: "info"} ]
  end

  def get_title(%Db.Assignments{title: title}) do
    title
  end

  def get_description(%Db.Assignments{description: description}) do
    description
  end

  def get_priority(%Db.Assignments{priority: priority}) do
    priority
  end

  def get_assignment_num(%Db.Assignments{id: id}) do
    id
  end

  def get_header(%{header: header}) do
    header
  end

  def get_background(%{background: background}) do
    background
  end

end
