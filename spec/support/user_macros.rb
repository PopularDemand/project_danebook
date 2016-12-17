module UserMacros
  def fill_out_sign_up_form(args ={})
    fill_in('user_first_name', with: args[:first_name] || 'Valid')
    fill_in('user_last_name', with: args[:last_name] || 'Info')
    fill_in('user_email', with: args[:email] || 'test@test.com')
    fill_in('user_password', with: args[:password] || 'password')
    fill_in('user_password_confirmation', with: args[:password_confirmation] || 'password')
    select('1956', from: 'user_profile_attributes_birthday_1i')
    select('January', from: 'user_profile_attributes_birthday_2i')
    select('15', from: 'user_profile_attributes_birthday_3i')
    choose('Female')
  end

  def sign_in(email, password)
    visit root_path
    within '#navbar-form' do
      fill_in('Email', with: email)
      fill_in('Password', with: password)
    end
    click_on("Login!")
  end

  def sign_up
    visit root_path
    fill_out_sign_up_form(first_name: user.first_name, last_name: user.last_name,
                              email: user.email)
    click_on('Sign Up')
  end
end