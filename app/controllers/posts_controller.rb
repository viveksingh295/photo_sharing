class PostsController < ApplicationController
  before_action :signed_in_user
  before_action :correct_user, only: :destroy

  def new 
    @post = Post.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "Post created!"
      redirect_to root_path
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def edit

  end

  def update

  end

  def destroy
    @post.destroy
    redirect_to root_path
  end

  def index
    @posts = Post.all.paginate(page: params[:page]).order('created_at DESC')
    respond_to do |format|
      format.html
      format.js
    end
  end

  private

  def correct_user
    @post = current_user.posts.find_by_id(params[:id])
    redirect_to root_path if @post.nil?
  end

  def post_params
    params.require(:post).permit(:caption, :image_url)
  end

end