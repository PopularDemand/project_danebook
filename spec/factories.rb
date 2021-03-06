include ActionDispatch::TestProcess

FactoryGirl.define do

  factory :user, aliases: [:author, :commenter, :liker, :poster] do
    after(:create) { |user| user.profile = build(:profile) }

    first_name "this"
    last_name "that"
    email "this@this.com"
    password 'password'
    sequence(:auth_token) { |n| SecureRandom.urlsafe_base64 + "#{n}"}

    trait :blank_password do
      password ''
    end
  end

  factory :photo do
    content { fixture_file_upload(Rails.root.join('app', 'assets', 'images', 'default_photo.png'), 'image/png') }
    poster

    trait :non_image do
      content { fixture_file_upload(Rails.root.join('README.md'), 'text/markdown') }
    end
  end

  factory :post do
    content 'This is post content'
    author
  end

  factory :comment do
    message "This is a comment message"
    commenter
    association :commentable, factory: :post #Default post comment

    trait :comment_comment do
      association :commentable, factory: :comment
    end

    trait :post_comment do
      association :commentable, factory: :post
    end
  end

  factory :like do
    liker
    association :likable, factory: :post

    trait :comment_like do
      association :likable, factory: :comment
    end

    trait :post_like do
      association :likable, factory: :post
    end
  end

  factory :profile do
    birthday "1985-05-05"
    college "Generic U"
    hometown 'Small Town'
    currently_lives 'Big City'
    telephone '800-800-9999'
    words_to_live_by 'Words to live by!'
    about_me 'about me'
    sex 'female'

    trait :non_default_telephone do
      telephone 18008675309
    end
  end
end