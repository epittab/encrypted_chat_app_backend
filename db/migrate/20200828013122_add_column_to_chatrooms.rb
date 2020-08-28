class AddColumnToChatrooms < ActiveRecord::Migration[6.0]
  def change
    add_column :chatrooms, :chatroom_name, :string
  end
end
