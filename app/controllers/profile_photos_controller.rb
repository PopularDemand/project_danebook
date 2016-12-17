class ProfilePhotosController < ApplicationController

  before_action :require_current_user, only: [:create, :destroy]
  before_action :set_photo, only: [:create, :destroy]

  def create
    # TODO refactor attr accessor 'profile photo' to user
    current_user.profile.profile_photo = @photo
    flash[:success] = "That's a good lookin' picture!"
    redirect_back_or_root
  end

  def destroy
  end

  private

    def set_photo
      if Photo.find(params[:photo_id])
        @photo = Photo.find(params[:photo_id])
      else
        flash[:warning] = "You must select a photo to set as profile pic."
        redirect_back_or_root
      end
    end

    def require_current_user
      unless Photo.find(params[:photo_id]).poster == current_user
        flash[:warning] = "Woah, now. You can only use your own photos."
        redirect_back_or_root
      end
    end
end