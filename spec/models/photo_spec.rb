require 'rails_helper'

describe Photo do

  let(:photo) { build(:photo) }
  
  describe 'Validations' do

    context 'valid information given' do
      it 'allows photo saving with valid content' do
        expect(photo).to be_valid
      end
    end

    context 'invalid information given' do
      it 'does not allow photo to be save without content' do
        photo.content = nil
        expect(photo).to_not be_valid
      end

      it 'does not allow photo to be save with non image file' do
        bad_photo = build(:photo, :non_image)
        expect(bad_photo).to_not be_valid
      end
    end

  end

  describe 'Associations' do

    context 'posters' do
      it 'has one poster' do
        expect(photo).to respond_to(:poster)
      end
    end

    context 'comments' do
      it 'has many comments' do
        expect(photo).to respond_to(:comments)
      end

      it 'has many commenters' do
        expect(photo).to respond_to(:commenters)
      end
    end

    context 'likes' do
      it 'has many likes' do
        expect(photo).to respond_to(:likes)
      end

      it 'has many likers' do
        expect(photo).to respond_to(:likers)
      end
    end

  end
end
