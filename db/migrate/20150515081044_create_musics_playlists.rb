class CreateMusicsPlaylists < ActiveRecord::Migration
  def change
    create_table :musics_playlists do |t|
      t.references :music, index: true
      t.references :playlist, index: true

      t.timestamps
    end
  end
end
