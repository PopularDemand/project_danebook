class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  has_secure_password
  has_one :profile, dependent: :destroy, inverse_of: :user
  accepts_nested_attributes_for :profile, reject_if: :all_blank

  validates :password, presence: true,
                       allow_nil: true
  validates :first_name, length: { maximum: 30 }
  validates :last_name, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX }
  before_save :capitalize_name


  def generate_token
    begin
      self[:auth_token] = SecureRandom.urlsafe_base64
    end while User.exists?(:auth_token => self[:auth_token])
  end

  def regenerate_auth_token
    self.auth_token = nil
    generate_token
    save!
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  private

    def capitalize_name
      self.first_name = first_name.capitalize
      self.last_name = last_name.capitalize
    end

    def downcase_email
      self.email.downcase
    end
end
