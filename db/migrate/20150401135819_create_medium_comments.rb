class CreateMediumComments < ActiveRecord::Migration
  def change
    create_table :medium_comments do |t|
      t.integer :comment_id
      t.integer :medium_id

      t.timestamps
    end
  end
end
