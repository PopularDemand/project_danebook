class PostsController < ApplicationController

  def index

  end

  def timeline
    @user = User.find(params[:user_id])
    @posts = @user.posts.order(created_at: :desc)
  end
end
