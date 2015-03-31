class CreateTableAlbumMusic < ActiveRecord::Migration
  def change
    create_table :albums_musics do |t|
    	t.references :album
    	t.references :music
    end
  end
end
