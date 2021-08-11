class AddColumnTorooms < ActiveRecord::Migration[6.0]
  def up
  	add_column :rooms , :user_id , :integer
  end
  def down
  	remove_column :rooms , :user_id , :integer
  end
end
