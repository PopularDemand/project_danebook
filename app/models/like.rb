class Like < ApplicationRecord
  belongs_to :likable, polymorphic: true, counter_cache: true
  belongs_to :liker, class_name: "User"

  def self.from_user_and_likable(user, likable)
     Like.where("likable_id = ? AND likable_type = ? AND liker_id = ?", likable.id, likable.class, user.id)
  end

  ## No use case
  # def self.from_user_and_likable(user, likable)
  #    Like.where("likable_id = ? AND likable_type = ? AND liker_id = ?", likable.id, likable.class, user.id)
  # end
end


# Need to destroy the actual like on unlike