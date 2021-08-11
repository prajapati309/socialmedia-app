class CommentsController < ApplicationController
	 skip_before_action :verify_authenticity_token
  def create
    
	  
    # @post = Post.find(params[:post_id])
     @comment = Post.find(params[:post_id]).comments.create(comment_params)
    #redirect_to post_path(@post)

    respond_to do |format|

      format.html  # index.html.erb
      format.js  {  }
    end
    #end
 
  end
  def show 
  	@comments = @post.comments.all
	@comment = @post.comments.build
  		
  end
  def index
  	@comments = Comment.all
  end
  def destroy
    
      @post = Post.find(params[:post_id])
        @comment = @post.comments.find(params[:id])
        @comment.destroy
        redirect_to post_path(@post)
  end
 
  private
    def comment_params
    	#params.fetch(:comment, {}).permit(:body)
      params.require(:comment).permit(:body)
    end
end
