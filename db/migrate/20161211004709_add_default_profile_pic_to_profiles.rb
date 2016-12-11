class AddDefaultProfilePicToProfiles < ActiveRecord::Migration[5.0]
  def change
    change_column :profiles, :profile_pic, :string, default: 'default_user.png'
  end
end
