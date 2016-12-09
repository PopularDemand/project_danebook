module UsersHelper

  def user_from_params
    User.find(params[:user_id] || params[:id])
  end
end
