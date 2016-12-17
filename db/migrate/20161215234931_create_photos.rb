class CreatePhotos < ActiveRecord::Migration[5.0]
  def change
    create_table :photos do |t|
      t.attachment :content
      t.integer :poster_id
      t.integer :likes_count, default: 0, null: false

      t.timestamps
    end
  end
end
