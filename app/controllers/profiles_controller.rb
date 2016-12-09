class ProfilesController < ApplicationController

  before_action :set_user, only: [:show, :edit]
  before_action :set_profile, only: [:show]

  def edit
    @user = current_user
    @profile = current_user.profile
  end

  def update
    @profile = current_user.profile
    if @profile.update_attributes(strong_profile_params)
      flash[:success] = "Profile Updated!"
      redirect_to current_user
    else
      flash[:danger] = "Profile not updated. Try again."
      render action: :edit
    end
  end

  def show 
  end

  private

    def strong_profile_params
      params.require(:profile).permit(:college, :hometown,
                               :currently_lives, :words_to_live_by,
                               :telephone, :about_me, :birthday, :sex)
    end

    def set_user
      # Unhack this
      user_id = params[:user_id] || params[:id]
      @user = User.find(user_id) || current_user
    end

    def set_profile
      @profile = @user.profile
    end
end
