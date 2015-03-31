class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :title
      t.string :imagepath
      t.text :description
      t.integer :downloads

      t.timestamps
    end
  end
end
