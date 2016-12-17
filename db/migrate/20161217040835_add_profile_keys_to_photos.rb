class AddProfileKeysToPhotos < ActiveRecord::Migration[5.0]
  def change
    add_column :photos, :covered_profile_id, :integer
    add_column :photos, :profiled_profile_id, :integer
  end
end
