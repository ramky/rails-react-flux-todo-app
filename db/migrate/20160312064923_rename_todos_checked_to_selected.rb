class RenameTodosCheckedToSelected < ActiveRecord::Migration
  def change
    rename_column :todos, :checked, :completed
  end
end
