class Comment < ApplicationRecord
  include Likable

  belongs_to :commentable, polymorphic: true
  belongs_to :author, class_name: "User"

  validates :message, presence: true
end
