class LikesController < ApplicationController

  before_action :store_referer, only: [:create, :destroy]
  before_action :set_likable, only: [:create, :destroy]

  def create
    @likable.liked_by(current_user)
    flash[:success] = "Yep, that's a pretty good #{@likable.class.to_s.downcase}."
    redirect_to referer
  end

  def destroy
    # params[:id] is like id. just destroy that like 
    # current_user.unlike(@likable)
    @likable.unliked_by(current_user)
    flash[:success] = "Unliked." 
    redirect_to referer
  end

  private

    def store_referer
      session[:referer] = URI(request.referer).path
    end

    def referer
      session.delete(:referer)
    end

    def set_likable
      parent_class = params[:type].classify.constantize
      @likable = parent_class.find(params[:likable_id])
    end

end
