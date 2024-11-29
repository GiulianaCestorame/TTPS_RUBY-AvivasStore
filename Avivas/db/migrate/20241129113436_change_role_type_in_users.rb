class ChangeRoleTypeInUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :role_int, :integer, default: 2
  end
end
