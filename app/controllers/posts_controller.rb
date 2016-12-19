class PostsController < ApplicationController

  before_action :require_current_user, only: [:destroy]
  before_action :require_logged_in_user

  def index
  end

  def timeline
    @user = User.find(params[:user_id])
    @posts = @user.posts.order(created_at: :desc)
    @post = Post.new
    # @comment = Comment.new
    # TODO: lol
    @friends = @user.friends
  end

  def create
    @post = current_user.posts.build(strong_post_params)
    if @post.save
      flash[:success] = "Post added."
      redirect_to user_timeline_path
    else
      flash[:warning] = "Post not added. #{@post.errors.full_messages}"
      redirect_to user_timeline_path
    end
  end

  def destroy
    @post = Post.find(params[:id])
    flash[:info] = "\"#{@post.content}\"...? Super Deleted!"
    @post.destroy
    redirect_to user_timeline_path(current_user)
  end


  private

    def strong_post_params
      params.require(:post).permit(:content)
    end

    def require_current_user
      unless current_user.id == Post.find(params[:id]).author_id
        flash[:warning] = "NOT AUTHORIZED TO DO THAT, BUB"
        redirect_to user_timeline_path(current_user)
      end
    end
end
