class AddColumnToUsers < ActiveRecord::Migration[6.0]
  def change
  	add_column :users, :gender, :integer , default: 0, index: true
  	add_column :users, :age, :integer  
  end
end
