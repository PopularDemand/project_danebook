class Profile < ApplicationRecord
  belongs_to :user, inverse_of: :profile
  has_one :profile_photo, class_name: 'Photo', foreign_key: :profiled_profile_id
  # Had to be a string.
  has_one :cover_photo, class_name: 'Photo', foreign_key: :covered_profile_id

  validates :birthday, presence: true
  validates :sex, inclusion: ['male', 'female']

  def profile_pic
    if !!self.profile_photo
      self.profile_photo.content
    else
      "default_user.png"
    end
  end

  def cover_image
    if !!self.cover_photo
      self.cover_photo.content
    else
      "http://htmlcolorcodes.com/assets/images/html-color-codes-color-tutorials-hero-00e10b1f.jpg"
    end
  end
end
