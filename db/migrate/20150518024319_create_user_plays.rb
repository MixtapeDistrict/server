class CreateUserPlays < ActiveRecord::Migration
  def change
    create_table :user_plays do |t|
      t.integer :user_id
      t.integer :music_id

      t.timestamps
    end
  end
end
