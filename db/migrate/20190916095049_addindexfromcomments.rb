class Addindexfromcomments < ActiveRecord::Migration[6.0]
  def change
  add_index :comments , [:commentable_id , :commentable_type] 
  end
end
