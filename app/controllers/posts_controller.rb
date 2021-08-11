class PostsController < ApplicationController

  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:show , :index]
   def index
    @posts = Post.paginate(page: params[:page], per_page: 20).order("created_at Desc")
  end

  def show
    
    @comment = Comment.new
    @comments = @post.comments
  end

  def new
    @post = Post.new
  end

  def edit
    authorize! :update, @posts  
  end

  def create
    @post = current_user.posts.create(post_params)
    if @post.save
      debugger
      UserMailer.welcome_email(current_user).deliver
      redirect_to post_path(@post)
    else
        render :new 
      end
  end

 
  def update
    authorize! :update, @posts  
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }

      else
        format.html { render :edit }
 
      end
    end
  end

 
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }


    end
  end

  private

    def set_post
      @post = Post.find(params[:id])
    end

 
    def post_params
      params.require(:post).permit(:content, image: [])
    end
end
