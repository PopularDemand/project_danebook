require 'rails_helper'

describe UsersController do
  
  let(:user) { create(:user) }

  let(:user_params) do
    attributes_for(:user, profile_attributes: attributes_for(:profile))
  end

  describe 'users#new' do

    context 'for a non-logged in user' do
      it 'correctly routes to path' do
        process :new
        expect(response).to have_http_status 200
      end
    end

    context 'for a logged in user' do
      it 'redirects the request' do
        controller_sign_in(user)
        process :new
        expect(response).to have_http_status 302
      end
    end
  end

  describe 'users#create' do
    context 'for a non-logged in user' do
      it 'increases the user count by one' do
        expect { 
          process :create, params: { user: user_params }
        }.to change(User, :count).by(1)
      end

      it 'redirects the user' do
        process :create, params: { user: user_params }
        expect(response).to have_http_status 302
      end
    end

    context 'for a logged in user' do 
      it 'redirects the request with a flash message' do
        controller_sign_in(user)
        process :create, params: { user: user_params }
        expect(response).to have_http_status 302
        expect(flash[:info]).to be_present
      end
    end
  end

  describe 'user#show' do
    context 'for a logged out user' do
      it 'redirects the request with a flash message' do
        process :show, params: { id: user.id }
        expect(response).to have_http_status 302
        expect(flash[:info]).to be_present
      end
    end
  end

  context 'for a logged in user' do
    it 'responds OK' do
      controller_sign_in(user)
      process :show, params: { id: user.id }
      expect(response).to have_http_status 200
    end
  end

end