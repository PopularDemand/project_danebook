class CommentsController < ApplicationController

  before_action :store_referer, only: [:create, :destroy]
  before_action :set_commentable, only: [:create]

  def create
    comment = @commentable.create_new_comment(current_user, strong_comment_params)
    User.send_comment_notification(@commentable.owner.id, current_user.id, comment.id)
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

    def set_commentable
      parent_class = params[:type].classify.constantize
      @commentable = parent_class.find(params[:commentable_id])
    end

end


# TODO do somthing like this
#     def set_commentable
#       parent_class = params[:type].classify.constantize
#       @commentable = parent_class.find(params[:post_id]) <<--- polymorph it
#     end