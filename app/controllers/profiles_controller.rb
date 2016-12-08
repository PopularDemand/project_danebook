class ProfilesController < ApplicationController

  def edit
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

  private

    def strong_profile_params
      params.require(:profile).permit(:college, :hometown,
                               :currently_lives, :words_to_live_by,
                               :telephone, :about_me, :birthday, :sex)
    end
end
