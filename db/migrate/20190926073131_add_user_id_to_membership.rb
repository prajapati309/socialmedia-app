class AddUserIdToMembership < ActiveRecord::Migration[6.0]
  def change
  	add_column :memberships, :user_id, :integer

  end
end
