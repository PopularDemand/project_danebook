class Post < ApplicationRecord
  include Likable
  belongs_to :author, class_name: "User"

  validates :content, presence: true

end
