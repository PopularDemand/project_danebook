require 'rails_helper'

feature User do
  context 'sign up' do

    feature 'with valid data' do

      it 'allows uses to sign up' do
        visit root_path
        fill_out_sign_up_form
        expect{ click_on('Sign Up') }.to change(User, :count).by(1)
      end

      it "redirects to user profile edit page" do
        visit root_path
        fill_out_sign_up_form
        click_on('Sign Up')
        expect(current_path).to match(/profile\/edit/)
      end
    end

    feature 'with invalid data' do
      it 'does not sign up user with invalid data' do
        visit root_path
        fill_out_sign_up_form(first_name: '', last_name: '',
                              email: 'invalid@email',
                              password: '')
        expect{ click_on('Sign Up') }.to change(User, :count).by(0)
      end

      it "redirects to sign up page" do
        visit root_path
        fill_out_sign_up_form(first_name: '', last_name: '',
                              email: 'invalid@email',
                              password: '')
        click_on('Sign Up')
        expect(page).to have_css('.sign-up-form')
      end
    end
  end

  context 'sign in' do

    let(:user) { create(:user) }

    feature 'with valid data' do
      it 'allows sign in with valid data' do
        visit root_path
        sign_in(user.email, user.password)
        click_on("Login!")
        expect(page).to have_content(user.full_name)
      end
    end

    feature 'with invalid data' do
      it 'redirects back to the sign in page' do
        visit root_path
        sign_in(user.email, "wrong password")
        click_on("Login!")
        expect(page).to have_content('Unable to log in')
      end
    end

  end
end