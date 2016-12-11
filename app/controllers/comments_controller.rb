class CommentsController < ApplicationController

  before_action :store_referer, only: [:create, :destroy]

  def create
    post = Post.find(params[:post_id])
    post.create_new_comment(current_user, strong_comment_params)
    flash[:success] = "Very insightful. Comment posted."
    redirect_to referer
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    flash[:success] = "#{comment.message}...? Poof, it's gone."
    redirect_to referer
  end

  private

    def strong_comment_params
      params.require(:comment).permit(:message)
    end

    def store_referer
      session[:referer] = URI(request.referer).path
    end

    def referer
      session.delete(:referer)
    end
end
