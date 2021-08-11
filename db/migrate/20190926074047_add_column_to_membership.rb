class AddColumnToMembership < ActiveRecord::Migration[6.0]
  def change
  	add_column :memberships, :room_id, :integer
  end
end
