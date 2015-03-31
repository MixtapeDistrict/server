class CreateMusics < ActiveRecord::Migration
  def change
    create_table :musics do |t|
      t.integer :user_id
      t.string :title
      t.string :filepath
      t.string :imagepath
      t.time :length
      t.integer :plays

      t.timestamps
    end
  end
end
