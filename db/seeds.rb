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

USER_NUM = 10
POST_PER_USER = 5
LIKES_PER_USER = 5
P_PICS = ['dog.png', 'smile.png', 'woman.png', 'doge.jpg']

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
    profile_pic: P_PICS.sample,
    telephone: Faker::PhoneNumber.cell_phone,
    user_id: user.id
  )

  POST_PER_USER.times do
    user.posts.create(
      content: Faker::Hacker.say_something_smart
    )
  end
end

User.all.each do |user|
  user.like(Post.all.sample)
end