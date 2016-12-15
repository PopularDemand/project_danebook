require 'rails_helper'

describe Profile do

  let(:profile) { build(:profile) }
  
  context 'Validations' do

    describe 'valid information given' do
      it 'passes birthday validation' do
        profile.user = build(:user)
        profile.birthday = Time.now
        expect(profile).to be_valid
      end
    end

  end



end