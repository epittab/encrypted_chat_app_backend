class AddColumnsToChatrooms < ActiveRecord::Migration[6.0]
  def change
    add_column :chatrooms, :user_id, :integer
  end
end
