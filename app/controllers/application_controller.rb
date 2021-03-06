class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :require_logged_in_user

  private
  def sign_in(user)
    user.regenerate_auth_token
    cookies.permanent[:auth_token] = user.auth_token
    @current_user = user
  end

  def sign_out
    @current_user = nil
    cookies.delete(:auth_token)
  end

  # TODO: clean up repetition
  def require_logged_in_user
    unless signed_in_user?
      flash[:info] = "You must sign in to view that page."
      redirect_to new_user_path
    end
  end

  def require_logged_out_user
    if signed_in_user?
      flash[:info] = "You can only do that once."
      redirect_to user_timeline_path(current_user)
    end
  end

  def require_current_user
    unless current_user.id.to_s == params[:id]
      flash[:warning] = "NOT AUTHORIZED TO DO THAT, BUB"
      redirect_to user_timeline_path(current_user)
    end
  end

  def redirect_back_or_root
    redirect_back(fallback_location: root_path)
  end

  def current_user
    @current_user ||= User.find_by_auth_token(cookies[:auth_token]) if cookies[:auth_token]
  end
  helper_method :current_user

  def signed_in_user?
    !!current_user
  end
  helper_method :signed_in_user

end
