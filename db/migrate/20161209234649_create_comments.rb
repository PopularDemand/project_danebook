class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.text :message
      t.integer :author_id
      t.references :commentable, polymorphic: true
      t.integer :likes_count, default: 0, null: false

      t.timestamps
    end
  end
end
