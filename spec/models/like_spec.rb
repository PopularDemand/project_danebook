require 'rails_helper'

describe Like do
  let(:like) { build(:like) }

  context 'Class Methods' do
    describe '.self_from_user_and_likable' do
      it 'returns a like with both parents ids' do
        post = create(:post)
        liker = post.author
        liker.like(post)
        expect(Like.from_user_and_likable(liker, post)[0]).to be_a(Like)
      end

      it 'returns correct like from parent ids' do
        like.save
        liker = like.liker
        likable = like.likable
        expect(Like.from_user_and_likable(liker, likable)[0]).to eq(like)
      end
    end
  end
end