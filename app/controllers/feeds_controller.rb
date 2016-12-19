class FeedsController < ApplicationController

  before_action :require_current_user, only: [:news_feed]
  before_action :set_user
  before_action :require_logged_in_user

  def timeline
    @posts = @user.posts.order(created_at: :desc).paginate(page: params[:page], per_page: 2)
    @post = Post.new
    @friends = @user.friends[0..8]
    @photos = @user.photos[0..8]
  end

  def news_feed
    @feed_items = Feed.new(current_user).all_friends.paginate(page: params[:page], per_page: 10)
    @friends = current_user.friends[0..8]
    @post = Post.new
    @photos = current_user.photos[0..8]
  end

  private

    def set_user
      @user = User.find(params[:user_id])
    end

    def require_current_user
      unless current_user.id.to_s == params[:user_id]
        flash[:warning] = "NOT AUTHORIZED TO DO THAT, BUB"
        redirect_to user_timeline_path(current_user)
      end
    end
end
