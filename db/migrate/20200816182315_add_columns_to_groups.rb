class AddColumnsToGroups < ActiveRecord::Migration[6.0]
  def change
    add_column :groups, :friender_id, :integer
    add_column :groups, :friendee_id, :integer
  end
end
