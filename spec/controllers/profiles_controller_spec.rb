# TODO test sad paths: what if bad information is given?

require 'rails_helper'

describe ProfilesController do

  let(:user) {create :user}
  let(:profile) { user.profile }
  let(:default_params) do
    { user_id: user.id, id: profile.id, profile: attributes_for(:profile) }
  end
  let(:non_default_params) do
    { user_id: user.id, id: profile.id, profile: attributes_for(:profile, :non_default_telephone) }
  end

  describe 'profile#edit' do

    context 'for a logged out user' do
      it 'redirects the request' do
        process :edit, params: default_params
        expect(response).to have_http_status 302
      end
      it 'sets an information flash' do
        process :edit, params: default_params
        expect(flash[:info]).to be_present
      end
    end

    context 'for a logged in user' do
      it 'responds OK' do
        controller_sign_in(user)
        process :edit, params: default_params
        expect(response).to have_http_status 200
      end
    end

  end


  describe 'profile#update' do

    context 'for a logged out user' do
      it 'redirects the request' do
        process :edit, params: default_params
        expect(response).to have_http_status 302
      end
      it 'sets an information flash' do
        process :edit, params: default_params
        expect(flash[:info]).to be_present
      end
    end

    context 'for a logged in user' do
      before { controller_sign_in(user) }

      it 'responds OK' do
        process :update, params: non_default_params
        expect(response).to have_http_status 302
      end

      it 'sets an information flash message' do
        process :update, params: non_default_params
        expect(flash[:success]).to be_present
      end

      it 'properly updates the profile' do
        before_telephone =  profile.telephone
        process :update, params: non_default_params
        profile.reload
        expect(profile.telephone).to_not eq before_telephone
      end
    end

  end


  describe 'profile#show' do

    context 'for a logged out user' do
      it 'redirects the request' do
        process :edit, params: default_params
        expect(response).to have_http_status 302
      end
      it 'sets an information flash' do
        process :edit, params: default_params
        expect(flash[:info]).to be_present
      end
    end

    context 'for a logged in user' do
      before { controller_sign_in(user) }

      it 'responds OK' do
        process :show, params: default_params
        expect(response).to have_http_status 200
      end
    end

  end
end