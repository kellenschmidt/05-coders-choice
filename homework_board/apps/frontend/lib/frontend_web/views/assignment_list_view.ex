defmodule FrontendWeb.AssignmentListView do
  use FrontendWeb, :view

  def assignments_for_column(column) do
    Db.Assignments.get_assignments_for_column(column.id)
  end

  def columns() do
    Db.Columns.get_columns()
  end

  def get_title(%{title: title}) do
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

  def get_color(%Db.Columns{color: color}) do
    color
  end

end
