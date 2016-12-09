class Like < ApplicationRecord
  belongs_to :likable, polymorphic: true, counter_cache: true
  belongs_to :liker, class_name: "User"
end
