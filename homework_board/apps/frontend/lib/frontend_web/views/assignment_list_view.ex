defmodule FrontendWeb.AssignmentListView do
  use FrontendWeb, :view

  def assignments_for_column(column) do
    Db.Assignments.get_assignments_for_column(column.id)
    |> IO.inspect
  end

  def columns() do
    Db.Columns.get_columns()
  end

  def get_labels(%Db.Assignments{labels: labels}) do
    labels
    |> handle_empty_labels
  end

  def get_title(label_id) when is_integer(label_id) do
    Db.Labels.get_label(label_id)
    |> get_title()
  end

  def get_title(%{title: title}) do
    title
  end

  def get_description(%Db.Assignments{description: description}) do
    description
  end

  def get_due_date(%Db.Assignments{due_date: %{month: month, day: day, hour: hour, minute: minute}}) do
    "#{month}/#{day} #{rem(hour, 12)}:#{get_zero_prefix(div(minute, 10))}#{minute} #{get_am_pm(div(hour, 12))}"
  end

  defp get_zero_prefix(0) do
    "0"
  end
  defp get_zero_prefix(_) do
    ""
  end

  defp get_am_pm(1) do
    "pm"
  end
  defp get_am_pm(0) do
    "am"
  end

  def get_assignment_num(%Db.Assignments{id: id}) do
    id
  end

  def get_color(label_id) when is_integer(label_id) do
    Db.Labels.get_label(label_id)
    |> get_color()
  end

  def get_color(%{color: color}) do
    color
  end

  defp handle_empty_labels(nil = _labels) do
    []
  end

  defp handle_empty_labels(labels) do
    labels
  end

end
