require 'rails_helper'

describe User do
  let(:user) { build(:user) }

  context 'Validations' do

    describe 'valid information given' do
      it 'passes first name validation' do
        user.first_name = 'First'
        expect(user).to be_valid
      end
      it 'passes last name validation' do
        user.last_name = 'last'
        expect(user).to be_valid
      end

      it 'passes email validation' do
        user.email = "foo@bar.com"
        expect(user).to be_valid
      end

      it 'passes password validation' do
        user.password = 'password'
        expect(user).to be_valid
      end
    end

    describe 'invalid information given' do
      it 'fails with invalid first name' do
        user.first_name = 't' * 31
        expect(user).to_not be_valid
        user.first_name = ''
        expect(user).to_not be_valid
      end

      it 'fails with invalid last name' do
        user.last_name = 't' * 31
        expect(user).to_not be_valid
        user.last_name = ''
        expect(user).to_not be_valid
      end

      it 'fails with invalid email' do
        user.email = 'fooatbardotocome'
        expect(user).to_not be_valid
        user.email = 'foo@bar'
        expect(user).to_not be_valid
        user.email = '$$bills@gmail.com'
        expect(user).to_not be_valid
        user.email = ''
        expect(user).to_not be_valid
      end

      it 'fails with invalid password' do
        bad_user = build(:user, :blank_password)
        expect(bad_user).to_not be_valid
      end
    end
  end

  context 'Associations' do

    describe 'posts' do
      # TODO be more specific
      it 'has many posts' do
        expect(user).to respond_to(:posts)
      end
    end

    describe 'comments' do
      it 'has many comments' do
        expect(user).to respond_to(:comments)
      end
      it 'has many post comments' do
        expect(user).to respond_to(:post_comments)
      end
      it 'has many comment comments' do
        expect(user).to respond_to(:comment_comments)
      end
    end

    describe 'likes' do
      it 'has many likes' do
        expect(user).to respond_to(:likes)
      end
      it 'has many liked posts' do
        expect(user).to respond_to(:liked_posts)
      end
      it 'has many liked comments' do
        expect(user).to respond_to(:liked_comments)
      end
    end

    context 'friendings' do

      describe 'received friendings' do
        it 'has many initiating friends' do
          expect(user).to respond_to(:received_friendings)
        end
      end

      describe 'initiatied friendings' do
        it 'has many receiving friends' do
          expect(user).to respond_to(:initiated_friendings)
        end
      end
    end
  end

  context "Instance Methods" do
    describe '#full_name' do
      it 'concatenates first and last names' do
        user.first_name = "Foo"
        user.last_name = "Bar"
        expect(user.full_name).to eq("Foo Bar")
      end
    end
  end

  context "Lifecycle Callbacks" do
    describe 'before save' do
      it 'capitalizes the user first and last name' do
        user.first_name = 'foo'
        user.last_name = 'bar'
        user.save!
        expect(user.full_name).to eq("Foo Bar")
      end

      it 'downcases the email' do
        user.email = 'FOO@BAR.COM'
        user.save!
        expect(user.email).to eq('foo@bar.com')
      end
    end
  end
end
