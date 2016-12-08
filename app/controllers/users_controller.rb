class UsersController < ApplicationController

  before_action :set_user, only: [:show]

  def new
    @user = User.new
    @profile = @user.build_profile
    render :new, layout: "new_user"
  end

  def create
    @user = User.new(strong_user_params)
    if @user.save
      flash[:success] = "Welcome to Danebook!"
      sign_in(@user)
      redirect_to edit_user_profile_path(@user)
    else
      flash[:warning] = "#{@user.errors.full_messages}"
      render :new, layout: "new_user"
    end
  end

  def show
    @profile = @user.profile
  end

  private

    def strong_user_params
      params.require(:user).permit(:first_name, :last_name, :password, :password_confirmation, :birthday, :sex, :email, profile_attributes: [:birthday, :sex])
    end

    def set_user
      @user = User.find(params[:id])
    end
end
