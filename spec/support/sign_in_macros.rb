module SignInMacros

  def controller_sign_in(user)
    cookies[:auth_token] = user.auth_token
  end

end