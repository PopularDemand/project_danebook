class ChangeAuthorIdToCommenterIdOnComments < ActiveRecord::Migration[5.0]
  def change
    rename_column :comments, :author_id, :commenter_id
  end
end
