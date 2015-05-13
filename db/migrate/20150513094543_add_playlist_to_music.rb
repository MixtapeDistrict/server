class AddPlaylistToMusic < ActiveRecord::Migration
  def change
    add_reference :musics, :playlist, index: true
  end
end
