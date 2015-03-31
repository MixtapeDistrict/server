class CreatePersonalComments < ActiveRecord::Migration
  def change
    create_table :personal_comments do |t|
      t.integer :comment_id
      t.integer :to_user_id

      t.timestamps
    end
  end
end
