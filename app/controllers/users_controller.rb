class UsersController < ApplicationController

  before_action :signed_in_user, only: [:show, :index]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:info] = "Signed Up Successfully"
      redirect_to login_path
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
    @post_count = @user.posts.count
    @followers_count = @user.followers.count
    @following_count = @user.following.count
    @posts = @user.posts.paginate(page: params[:page], per_page: 9).order('created_at DESC')
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 50).order('created_at DESC')
    respond_to do |format|
      format.html
      format.js
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :password, :password_confirmation)
  end
end