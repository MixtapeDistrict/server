class CreateMedia < ActiveRecord::Migration
  def change
    create_table :media do |t|
      t.integer :user_id
      t.string :title
      t.string :file_path
      t.string :image_path
      t.integer :downloads
      t.string :media_type

      t.timestamps
    end
  end
end
