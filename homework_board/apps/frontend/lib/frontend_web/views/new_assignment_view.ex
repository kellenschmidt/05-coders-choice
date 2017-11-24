defmodule FrontendWeb.NewAssignmentView do
  use FrontendWeb, :view

  def get_columns() do
    Db.Columns.get_columns()
  end

end
