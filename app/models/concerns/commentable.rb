require 'active_support/concern'

module Commentable
  extend ActiveSupport::Concern

  included do
    has_many :comments, as: :commentable
    has_many :commenters,
             through: :comments,
             source: :commenter
  end

  def create_new_comment(user, comment_attrs)
    attrs = comment_attrs.to_h
    attrs[:commenter_id] = user.id
    comments.create(attrs)
  end

  # how to make this a class method?
  # Or better way to handle
  def owner
    parent_class = self.class.to_s
    case parent_class
    when 'Post'
      user = :author
    when 'Photo'
      user = :poster
    else
      return false
    end
    self.send(user)
  end
end