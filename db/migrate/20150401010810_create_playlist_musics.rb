class CreatePlaylistMusics < ActiveRecord::Migration
  def change
    create_table :playlist_musics do |t|
      t.integer :playlist_id
      t.integer :music_id

      t.timestamps
    end
  end
end
