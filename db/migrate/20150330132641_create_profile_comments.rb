class CreateProfileComments < ActiveRecord::Migration
  def change
    create_table :profile_comments do |t|
      t.integer :comment_id
      t.integer :to_user_id

      t.timestamps
    end
  end
end
