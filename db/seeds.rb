# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts 'destroying users'
User.destroy_all
puts 'destroying profiles'
Profile.destroy_all
puts 'destroying likes'
Like.destroy_all
puts 'destroying posts'
Post.destroy_all

USER_NUM = 40
POST_PER_USER = 5
LIKES_PER_USER = 5
PICS = ['dog.png', 'smile.png', 'woman.png', 'doge.jpg', 
          'you.jpeg', 'joinus.jpeg', 'cookies.jpeg', 'rules.jpg']
COMMENTS_PER_POST = 2
POST_LIKES = 10
COMMENT_LIKES = 3
INITIATED_FRIENDSHIPS = 5



USER_NUM.times do |i|
  user = User.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: "test#{i}@test.com",
    password: "password",
    password_confirmation: "password"
  )
  Profile.create(
    college: Faker::Educator.university,
    hometown: Faker::Pokemon.location,
    currently_lives: Faker::Pokemon.location,
    words_to_live_by: Faker::Company.catch_phrase,
    about_me: "totally human " * 25,
    birthday: "1985-05-05",
    sex: ['male', 'female'].sample,
    # profile_pic: P_PICS.sample,
    telephone: Faker::PhoneNumber.cell_phone,
    user_id: user.id
  )

  POST_PER_USER.times do
    post = user.posts.create(
      content: Faker::Hacker.say_something_smart
    )
    post.created_at = (rand*10).days.ago
    post.save!
  end

  3.times do
    user.photos.create(
      content: File.open(File.join(Rails.root, "/app/assets/images/#{PICS.sample}"))
    )
  end

  user.profile.cover_photo = user.photos.sample
  user.profile.profile_photo = user.photos.sample
  # user.photos.sample.profiled_profile_id = user.profile.id
end

Post.all.each do |post|
  COMMENTS_PER_POST.times do
    commenter_id = User.all.sample.id
    post.comments.create(
      commenter_id: commenter_id,
      message: Faker::Hipster.sentence
    )
  end
end

User.all.each do |user|
  POST_LIKES.times do
    user.like(Post.all.sample)
  end
  COMMENT_LIKES.times do
    user.like(Comment.all.sample)
  end
  INITIATED_FRIENDSHIPS.times do
    friend = User.all.sample
    while friend == user || user.friends.include?(friend)
      friend = User.all.sample
    end
    user.receiving_friends << friend
  end
end
