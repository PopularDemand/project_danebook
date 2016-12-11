class Comment < ApplicationRecord
  include Likable

  belongs_to :commentable, polymorphic: true
  belongs_to :commenter, class_name: "User"

  validates :message, presence: true


  def self.from_user_and_commentable(user, commentable)
     Comment.where("commentable_id = ? AND commentable_type = ? AND commenter_id = ?", commentable.id, commentable.class, user.id)
  end
end
