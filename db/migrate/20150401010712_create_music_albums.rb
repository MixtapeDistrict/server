class CreateMusicAlbums < ActiveRecord::Migration
  def change
    create_table :music_albums do |t|
      t.integer :music_id
      t.integer :album_id

      t.timestamps
    end
  end
end
