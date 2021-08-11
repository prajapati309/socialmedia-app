class User < ApplicationRecord
  has_many_attached :avatar
  
  has_many :visits, class_name: "Ahoy::Visit"
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
    enum gender: { male: 0, female: 1, not_sure: 2, prefer_not_to_disclose: 3 }
	#validates :age , presence: true , numericality: { only_integer: true , greater_than: 18 , message: "age should be greater than 18 "} 

  has_many :chatroom_users
  has_many :chatrooms , through: :chatroom_users
  has_many :chatroom_messages 
	has_many :posts , dependent: :destroy
	has_many :comments, through: :posts 
#has_many :pictures , as: :imageable
#has_many :events 	
#has_many :follwers , as: :followable
	has_many :likes , dependent: :destroy
#acts_as_followable
#acts_as_follower
  has_many :events, dependent: :destroy
  #has_many :friendships
  #has_many :friends, :through => :friendships

  #has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  #has_many :inverse_friends, :through => :inverse_friendships, :source => :user
  has_many :friendships , dependent: :destroy
  has_many :accepted_friendships,-> {where status: 2 },:class_name => "Friendship"
  has_many :requested_friendships,
  -> {where status: 0 },
  :class_name => "Friendship"
  has_many :pending_friendships,
  -> {where status: 1 },
  :class_name => "Friendship"
  has_many :friends, :through => :accepted_friendships
  has_many :requested_friends, :through => :requested_friendships, :source => :friend
  has_many :pending_friends, :through => :pending_friendships, :source => :friend

  has_many :sent_conversations, class_name: 'Conversation', foreign_key: 'sender_id'
has_many :received_conversations, class_name: 'Conversation', foreign_key: 'received_id'
has_many :messages ,dependent: :destroy
has_many :rooms , through: :memberships
has_many :memberships , dependent: :destroy
has_many :newsfeed
 # friendship relation  
validates :first_name, :last_name, presence: true 
validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
validates :email , uniqueness: true
validates :password , presence: true , confirmation: true, length: { within: 6...15 } , on: :create 

  def username
  	return self.email.split('@')[0].capitalize
  end
  def activate_account!   
  update_attribute :is_active, true 
  end

  def deactivate_account!   
    update_attribute :is_active, false 
  end
  def active_for_authentication?
      super and self.is_active?
  end
  def inactive_message
      "You are not allowed to log in."
  end
end
