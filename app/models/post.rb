class Post < ApplicationRecord
  belongs_to :author, class_name: "User"
  # TODO: add like count to posts table
  has_many :likes, as: :likable
  has_many :likers,
           through: :likes,
           source: :liker

  validates :content, presence: true
end
