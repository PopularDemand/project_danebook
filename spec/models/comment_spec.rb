require 'rails_helper'

describe Comment do
  let(:comment) { build(:comment) }
  
  context 'Validations' do

    describe 'valid information given' do
      it 'passes message validation' do
        comment.message = 'This is message'
        expect(comment).to be_valid
      end
    end

    describe 'invalid information given' do
      it 'fails with invalid message' do
        comment.message = ''
        expect(comment).to_not be_valid
      end
    end
  end

  context 'Associations' do

    describe 'likes' do
      it 'has many likes' do
        expect(comment).to respond_to(:likes)
      end

      it 'has many likers' do
        expect(comment).to respond_to(:likers)
      end
    end

    describe 'commenter' do
      it 'has one commenter' do
        expect(comment).to respond_to(:commenter)
      end
    end
  end

  context 'Class Methods' do

    describe '.from_user_and_commentable' do
      it 'returns comments' do
        comment.save
        commenter = comment.commenter
        commentable = comment.commentable
        expect(Comment.from_user_and_commentable(commenter, commentable)[0]).to eq(comment)
      end
    end
  end

end