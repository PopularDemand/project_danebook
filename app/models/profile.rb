class Profile < ApplicationRecord
  belongs_to :user, inverse_of: :profile
  validates :birthday, presence: true
  validates :sex, inclusion: ['male', 'female']
end
