class CreateTableMusicPlaylist < ActiveRecord::Migration
  def change
    create_table :musics_playlists do |t|
    	t.references :music 
    	t.references :playlist 
    end
  end
end
