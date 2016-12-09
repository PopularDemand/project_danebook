require 'active_support/concern'

module Likable
  extend ActiveSupport::Concern

  included do
    has_many :likes, as: :likable
    has_many :likers,
             through: :likes,
             source: :liker
  end

  def liked_by(user)
    self.likers << user
  end

end