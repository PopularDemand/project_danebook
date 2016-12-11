module FriendingsHelper

  # TODO the jank is real. unjankify class_options. called from jumbotron

  def friendship_button(user, btn_size: "md", class_options: '')
    if current_user.friends_with?(user)
      button_tag "End Friendship", class: "btn btn-#{btn_size} btn-danger #{class_options}"
    else
      button_tag "Add Friend", class: "btn btn-#{btn_size} btn-success #{class_options}"
    end
  end

end