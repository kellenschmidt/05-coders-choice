defmodule FrontendWeb.AssignmentListView do
  use FrontendWeb, :view

  def assignment_list() do
    Db.Assignments.get_assignments()
  end

  def getTitle(%Db.Assignments{title: title}) do
    title
  end

  def getDescription(%Db.Assignments{description: description}) do
    description
  end

  def getPriority(%Db.Assignments{priority: priority}) do
    priority
  end

end
