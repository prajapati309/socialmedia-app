class Post < ApplicationRecord

	#has_one_attached :image
	has_many_attached :image
  	belongs_to :user
   	has_many :comments , as: :commentable , dependent: :destroy
  	#has_many :pictures , as: :imageable
  	has_many :likes, dependent: :destroy

end
