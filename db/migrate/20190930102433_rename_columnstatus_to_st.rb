class RenameColumnstatusToSt < ActiveRecord::Migration[6.0]
  def up
  rename_column :friendships, :status, :old_status
    add_column :friendships, :status, :integer
  end
  def down
  	rename_column :friendships, :old_status, :status
  	remove_column :friendships, :status, :integer
  end

end
