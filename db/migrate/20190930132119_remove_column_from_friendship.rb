class RemoveColumnFromFriendship < ActiveRecord::Migration[6.0]
  def change
  	remove_column :friendships ,:old_status
  end
end
