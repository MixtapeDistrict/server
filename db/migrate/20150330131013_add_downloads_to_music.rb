class AddDownloadsToMusic < ActiveRecord::Migration
  def change
    add_column :musics, :downloads, :integer
  end
end
