class Room < ApplicationRecord
has_many :room_messages, dependent: :destroy,
                         inverse_of: :room
#has_many :friendships, :dependent => :destroy

has_many :memberships, :dependent => :destroy
has_many :users , through: :memberships 


  
end
