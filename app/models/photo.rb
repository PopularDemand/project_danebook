class Photo < ApplicationRecord

  include Commentable
  include Likable
  belongs_to :poster, class_name: "User", counter_cache: true
  belongs_to :covered_profile, class_name: "Profile", foreign_key: :covered_profile_id, optional: true
  belongs_to :profiled_profile, class_name: "Profile", foreign_key: :profiled_profile_id, optional: true

  has_attached_file :content, styles: { medium: '200x200', thumb: '95x95' }

  validates :content, presence: true
  validates_attachment_content_type :content, content_type: /\Aimage\/.*\Z/
end
