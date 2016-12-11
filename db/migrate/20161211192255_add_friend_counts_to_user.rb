class AddFriendCountsToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :received_friendings_count, :integer, :default => 0, :null => false
    add_column :users, :initiated_friendings_count, :integer, :default => 0, :null => false
  end
end
