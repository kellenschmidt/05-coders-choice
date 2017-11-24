Db.Columns.delete_all_columns()

Db.Columns.add_column(%Db.Columns{title: "Upcoming", sort_order: 0, color: "primary"})
Db.Columns.add_column(%Db.Columns{title: "In Progress", sort_order: 1, color: "success"})
Db.Columns.add_column(%Db.Columns{title: "Completed", sort_order: 2, color: "info"})
