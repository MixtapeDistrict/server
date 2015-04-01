class CreateMusics < ActiveRecord::Migration
  def change
    create_table :musics do |t|
      t.string :image_path
      t.integer :medium_id
      t.integer :plays
      t.string :genre

      t.timestamps
    end
  end
end
