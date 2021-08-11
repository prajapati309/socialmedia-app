class ChangeColumnName < ActiveRecord::Migration[6.0]
  def change
  	rename_column :conversations, :receriver_id, :receiver_id

  end
end
