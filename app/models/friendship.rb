class Friendship < ApplicationRecord
	belongs_to :user
	enum status: [:requested, :pending, :accepted]
	belongs_to :friend , class_name: 'User'
	def self.request(user, friend)
	unless user == friend
	transaction do
	create(:user => user, :friend => friend, :status => 1)
	create(:user => friend, :friend => user, :status => 0)
	end
	end
	end
	def self.accept(user, friend)
	transaction do
	updated_at = Time.now
	accept_one_side(user, friend, updated_at)
	accept_one_side(friend, user, updated_at)
	end
	end
	def self.breakup(user, friend)
		
	transaction do
	find_by_user_id_and_friend_id(user, friend).destroy
	find_by_user_id_and_friend_id(friend, user).destroy
	end
	end
	private
	def self.accept_one_side(user, friend, updated_at)
	request = find_by_user_id_and_friend_id(user, friend)
	request.status = 2
	request.save!
	end
end
