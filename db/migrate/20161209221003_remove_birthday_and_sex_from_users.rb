class RemoveBirthdayAndSexFromUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :birthday
    remove_column :users, :sex

  end
end
