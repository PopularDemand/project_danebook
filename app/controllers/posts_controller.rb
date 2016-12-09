class PostsController < ApplicationController

  def index

  end

  def timeline
    @user = User.find(params[:user_id])
    @posts = @user.posts.order(created_at: :desc)
    @post = Post.new
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
    redirect_to user_timeline_path
  end


  private

    def strong_post_params
      params.require(:post).permit(:content)
    end
end
