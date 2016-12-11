class Post < ApplicationRecord
  include Likable
  include Commentable
  belongs_to :author, class_name: "User"

  validates :content, presence: true

end
