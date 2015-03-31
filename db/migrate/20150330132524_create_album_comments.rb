class CreateAlbumComments < ActiveRecord::Migration
  def change
    create_table :album_comments do |t|
      t.integer :comment_id
      t.integer :album_id

      t.timestamps
    end
  end
end
