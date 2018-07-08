class FeedsController < ApplicationController
  before_action :signed_in_user
  def home
    @posts = current_user.feed.paginate(page: params[:page]).order('created_at DESC')
    respond_to do |format|
      format.html
      format.js
    end
  end

end