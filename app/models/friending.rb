class Friending < ApplicationRecord
  belongs_to :initiator, class_name: "User", counter_cache: :initiated_friendings_count
  belongs_to :recipient, class_name: "User", counter_cache: :received_friendings_count

  def self.destroy_friendship_between(unfriender_id, old_friend_id)
    Friending.where("initiator_id = ? AND recipient_id = ? OR initiator_id = ? AND recipient_id = ?",
      unfriender_id, old_friend_id, old_friend_id, unfriender_id )
    .destroy_all
  end
end
