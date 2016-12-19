class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  
  has_secure_password

  has_one   :profile,
              dependent: :destroy,
              inverse_of: :user

  has_many  :photos,
              dependent: :destroy,
              foreign_key: :poster_id

  has_many  :posts,
             dependent: :destroy,
              foreign_key: :author_id

  has_many  :comments,
              foreign_key: :commenter_id
  has_many  :post_comments,
              through: :comments,
              source: :commentable,
              source_type: "Post"
  has_many  :comment_comments,
              through: :comments, 
              source: :commentable,
              source_type: "Comment"

  has_many  :likes,
              foreign_key: :liker_id
  has_many  :liked_posts,
              through: :likes,
              source: :likable,
              source_type: "Post"
  has_many  :liked_comments,
              through: :likes,
              source: :likable,
              source_type: "Comment"

  has_many  :received_friendings,
              class_name: "Friending",
              foreign_key: :recipient_id
  has_many  :initiating_friends,
              through: :received_friendings,
              foreign_key: :recipient_id,
              source: :initiator

  has_many  :initiated_friendings,
              class_name: "Friending",
              foreign_key: :initiator_id
  has_many  :receiving_friends,
              through: :initiated_friendings,
              foreign_key: :initator_id,
              source: :recipient # what the join table calls it

  accepts_nested_attributes_for :profile, reject_if: :all_blank

  validates :password,   length: { minimum: 6 },
                         allow_nil: true
  validates :first_name, length: { in: 1..30 }
  validates :last_name,  length: { in: 1..30 }
  validates :email,      presence: true, length: { maximum: 255 },
                         format: { with: VALID_EMAIL_REGEX }
  
  before_save :capitalize_name,
              :downcase_email


  def self.send_welcome_email(id)
    user = find(id)
    UserMailer.welcome(user).deliver!
  end

  def self.send_comment_notification(receiver_id, sender_id, comment_id)
    sender = find(sender_id)
    receiver = find(receiver_id)
    comment = Comment.find(comment_id)
    UserMailer.comment_notification(receiver, sender, comment).deliver!
  end

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

  def like(likable)
    # TODO: redundant? used anywhere???
    likable.liked_by(self)
  end

  def unfriend(user)
    Friending.destroy_friendship_between(self.id, user)
  end

  def friends
    friends = self.initiating_friends + self.receiving_friends
    friends.uniq
  end

  def friends_with?(user)
    self.friends.include?(user)
  end

  # TODO add db columns
  def friend_count
    self.friends.size
  end

  private

    def capitalize_name
      self.first_name = first_name.capitalize
      self.last_name = last_name.capitalize
    end

    def downcase_email
      self.email  = email.downcase
    end
end
