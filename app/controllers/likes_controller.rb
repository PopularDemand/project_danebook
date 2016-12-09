class LikesController < ApplicationController

  before_action :store_referer

  def create
    # TODO: make function to determine polymorphism
    post = Post.find(params[:post_id])
    current_user.liked_posts << post
    redirect_to referer
  end

  def destroy
    post = Post.find(params[:post_id])
    current_user.unlike(post)
    redirect_to referer
  end

  private

    def store_referer
      session[:referer] = URI(request.referer).path
    end

    def referer
      session.delete(:referer)
    end

end
