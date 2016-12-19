class SessionsController < ApplicationController

  skip_before_action :require_logged_in_user, only: [:create, :destroy]

  def create
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      sign_in(@user)
      flash[:success] = "Welcome back!"
      redirect_to current_user
    else
      flash[:warning] = "Unable to log in..."
      redirect_to root_path
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end
end
