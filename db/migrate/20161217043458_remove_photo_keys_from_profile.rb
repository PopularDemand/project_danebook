class RemovePhotoKeysFromProfile < ActiveRecord::Migration[5.0]
  def change
    remove_column :profiles, :profile_photo_id
    remove_column :profiles, :cover_photo_id
  end
end
