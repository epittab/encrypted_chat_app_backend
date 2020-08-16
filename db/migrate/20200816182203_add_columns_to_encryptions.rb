class AddColumnsToEncryptions < ActiveRecord::Migration[6.0]
  def change
    add_column :encryptions, :key, :string
    add_column :encryptions, :encrypt_type, :string
  end
end
