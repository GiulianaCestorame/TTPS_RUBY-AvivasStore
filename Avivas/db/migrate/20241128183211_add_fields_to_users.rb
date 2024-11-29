class AddFieldsToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :username, :string
    add_index :users, :username, unique: true

    add_column :users, :phone, :string

    add_column :users, :role, :integer
    add_index :users, :role

    add_column :users, :joined_at, :datetime
    add_column :users, :active, :boolean, default: true
  end
end
