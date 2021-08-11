	class LikesController < ApplicationController
 before_action :find_post
 before_action :find_like, only: [:destroy]
  	def create
     if already_liked?
			flash[:notice] = "You cant like more than onces . "
	  else
	    @post.likes.create(user_id: current_user.id)
	    flash[:notice] = "you like the post "
	  end
	  #redirect_to post_path(@post)
	  respond_to do |format|

      format.html  # index.html.erb
      format.js  {  }
    end
	end
	def destroy
		  if !(already_liked?)
		    flash[:notice] = "Cannot unlike"
		  else
		    @like.destroy
		    
		  end
		  redirect_to post_path(@post)
	end
	def index
		@likes = Like.all
	end
	def already_liked?
		Like.where(user_id: current_user.id, post_id:
  		params[:post_id]).exists?
	end
	def find_like
   		@like = @post.likes.find(params[:id])
	end
  	private
  	def find_post
    @post = Post.find(params[:post_id])
  	end
end
