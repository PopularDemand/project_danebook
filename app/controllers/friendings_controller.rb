class FriendingsController < ApplicationController

  def create
    new_friend = User.find(params[:new_friend])
    if current_user.friends_with?(new_friend)
      flash[:warning] = "Already buddies, pal."
      redirect_to new_friend
    else
      current_user.receiving_friends << new_friend
      flash[:success] = "Now friends with #{new_friend.first_name}!"
      redirect_to new_friend
    end
  end

  def destroy
    # May want to pass around full user obj
    old_friend = params[:user_id]

    current_user.unfriend(old_friend)
    flash[:warning] = "No longer friends with #{User.find(old_friend).full_name}"
    redirect_to user_timeline_path(old_friend)
  end


  private

    def strong_friending_params
      params.permit(:user)
    end
end