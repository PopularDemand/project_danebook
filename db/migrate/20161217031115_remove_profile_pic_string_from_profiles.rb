class RemoveProfilePicStringFromProfiles < ActiveRecord::Migration[5.0]
  def change
    remove_column :profiles, :profile_pic
  end
end
