class CreateMusicComments < ActiveRecord::Migration
  def change
    create_table :music_comments do |t|
      t.integer :comment_id
      t.integer :music_id

      t.timestamps
    end
  end
end
