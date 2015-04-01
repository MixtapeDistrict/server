class AddDescriptionAndWebsitelinkAndTracksheardAndImagepathToUsers < ActiveRecord::Migration
  def change
    add_column :users, :description, :text
    add_column :users, :website_link, :string
    add_column :users, :tracks_heard, :text
    add_column :users, :image_path, :string
  end
end
