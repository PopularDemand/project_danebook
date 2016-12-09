class AddProfilePicToProfiles < ActiveRecord::Migration[5.0]
  def change
    add_column :profiles, :profile_pic, :string
  end
end
