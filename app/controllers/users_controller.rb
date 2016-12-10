class UsersController < ApplicationController

  before_action :require_login, except: [:new, :create]
  before_action :set_user, only: [:show]
  before_action :require_current_user, only: [:edit, :update, :destroy]

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

    def require_login
      unless signed_in_user?
        flash[:info] = "You must be signed in to access that page."
        redirect_to new_user_path
      end
    end

    def require_current_user
      unless current_user.id.to_s == params[:id]
        flash[:warning] = "NOT AUTHORIZED TO DO THAT, BUB"
        redirect_to user_timeline_path(current_user)
      end
    end
end
