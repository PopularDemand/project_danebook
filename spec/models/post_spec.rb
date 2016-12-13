require 'rails_helper'

describe Post do
  let(:post) { build(:post) }
  
  context 'Validations' do

    describe 'valid information given' do
      it 'passes content validation' do
        post.content = 'This is content'
        expect(post).to be_valid
      end
    end

    describe 'invalid information given' do
      it 'fails with invalid content' do
        post.content = ''
        expect(post).to_not be_valid
      end
    end
  end

  context 'Associations' do

    describe 'likes' do
      it 'has many likes' do
        expect(post).to respond_to(:likes)
      end

      it 'has many likers' do
        expect(post).to respond_to(:likers)
      end
    end

    describe 'comments' do
      it 'has many comments' do
        expect(post).to respond_to(:comments)
      end
      it 'has many commenters' do
        expect(post).to respond_to(:commenters)
      end
    end

    describe 'author' do
      it 'has one author' do
        expect(post).to respond_to(:author)
      end
    end
  end

end