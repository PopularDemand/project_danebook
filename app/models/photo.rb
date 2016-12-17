class Photo < ApplicationRecord

  include Commentable
  include Likable
  belongs_to :poster, class_name: "User", counter_cache: true

  has_attached_file :content, styles: { medium: '200x200' }

  validates :content, presence: true
  validates_attachment_content_type :content, content_type: /\Aimage\/.*\Z/
end
