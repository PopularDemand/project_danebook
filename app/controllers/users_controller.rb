class UsersController < ApplicationController

  skip_before_action :require_logged_in_user, only: [:new, :create]
  before_action :set_user, only: [:show]
  before_action :require_logged_out_user, only: [:create]
  # not being used
  # before_action :require_current_user, only: [:edit, :update, :destroy]

  def new
    if signed_in_user?
      redirect_to user_timeline_path(current_user)
    else
      @user = User.new
      @profile = @user.build_profile
      render :new, layout: "new_user"
    end
  end

  def create
    @user = User.new(strong_user_params)
    if @user.save
      User.send_welcome_email(@user.id)
      flash[:success] = "Welcome to Danebook!"
      sign_in(@user)
      redirect_to edit_user_profile_path(@user)
    else
      flash[:warning] = "#{@user.errors.full_messages}"
      render :new, layout: "new_user"
    end
  end

  def show
    # TODO find all references to this action and change them to the timeline
    redirect_to user_timeline_path(@user)
  end

  private

    def strong_user_params
      params.require(:user).permit(:first_name, :last_name, :password, :password_confirmation, :birthday, :sex, :email, profile_attributes: [:birthday, :sex])
    end

    def set_user
      @user = User.find(params[:id])
    end

    # def require_login
    #   unless signed_in_user?
    #     flash[:info] = "You must be signed in to access that page."
    #     redirect_to new_user_path
    #   end
    # end

    def require_current_user
      unless current_user.id.to_s == params[:id]
        flash[:warning] = "NOT AUTHORIZED TO DO THAT, BUB"
        redirect_to user_timeline_path(current_user)
      end
    end
end
