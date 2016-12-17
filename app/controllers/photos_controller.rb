class PhotosController < ApplicationController

  before_filter :require_current_user, only: [:create, :new]
  before_filter :set_user, only: [:show, :new]
  before_filter :require_friendship, only: :show

  def new
    @photo = Photo.new
  end

  def create
    @photo = current_user.photos.build(strong_photo_params)
    if @photo.save
      flash[:success] = "Great picture! That's uploaded."
      redirect_to user_photos_path(current_user)
    else
      flash[:warning] = "Unable to upload photo. #{@photo.errors.full_messages}"
      render :new
    end
  end

  def index
    @user = User.includes(:photos).find(params[:user_id])
  end

  def show
    @photo = Photo.find(params[:id])
  end

  def destroy
  end

  private

  def strong_photo_params
    params.require(:photo).permit(:content)
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def require_current_user
    unless current_user.id.to_s == params[:user_id]
      flash[:warning] = "NOT AUTHORIZED TO DO THAT, BUB"
      redirect_to user_timeline_path(current_user)
    end
  end

  def require_friendship
    user = User.find(params[:user_id])
    unless current_user.friends_with?(user) || user == current_user
      flash[:warning] = "You must be friends with #{user.first_name} to view that."
      redirect_back(fallback_location: root_path)
    end
  end
end
