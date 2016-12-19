class FeedsController < ApplicationController

  before_action :require_logged_in_user

  def timeline
    @user = User.find(params[:user_id])
    @posts = @user.posts.order(created_at: :desc).paginate(page: params[:page], per_page: 2)
    @post = Post.new
    # @comment = Comment.new
    # TODO: lol
    @friends = @user.friends[0..8]
  end



end
