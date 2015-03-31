class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.integer :user_id
      t.text :description
      t.text :website_line
      t.text :tracks_heard
      t.string :imagepath

      t.timestamps
    end
  end
end
