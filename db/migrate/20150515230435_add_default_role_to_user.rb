class AddDefaultRoleToUser < ActiveRecord::Migration
  def up
    change_column :users, :role, :integer, default: 0, null: false
  end

  def down
    change_column :users, :role, :integer, default: nil
  end
end
