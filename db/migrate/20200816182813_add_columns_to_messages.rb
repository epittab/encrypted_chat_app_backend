class AddColumnsToMessages < ActiveRecord::Migration[6.0]
  def change
    add_column :messages, :message_text, :string
    add_column :messages, :chatroom_id, :integer
    add_column :messages, :user_id, :integer
    add_column :messages, :encryption_id, :integer
  end
end
