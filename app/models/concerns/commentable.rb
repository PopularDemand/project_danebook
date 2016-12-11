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
    puts "before: "
    p attrs
    attrs[:commenter_id] = user.id
    puts "After: "
    p attrs
    comments.create(attrs)
  end
end