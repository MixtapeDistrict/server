class CreateAlbumRatings < ActiveRecord::Migration
  def change
    create_table :album_ratings do |t|
      t.integer :album_id
      t.integer :user_id
      t.integer :rating

      t.timestamps
    end
  end
end
