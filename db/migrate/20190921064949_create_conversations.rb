class CreateConversations < ActiveRecord::Migration[6.0]
  def change
    create_table :conversations do |t|
      t.integer :sender_id
      t.integer :receriver_id

      t.timestamps
    end
    add_index :conversations, [:sender_id, :receiver_id], unique: true
    
  end
end
