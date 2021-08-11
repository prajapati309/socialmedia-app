class Membership < ApplicationRecord
  attr_accessor :user_id, :room_id
  belongs_to :user
  belongs_to :room
  

end
