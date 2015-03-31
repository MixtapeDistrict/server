class CreateMusicRatings < ActiveRecord::Migration
  def change
    create_table :music_ratings do |t|
      t.integer :user_id
      t.integer :music_id
      t.integer :rating

      t.timestamps
    end
  end
end
