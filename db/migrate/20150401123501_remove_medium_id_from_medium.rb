class RemoveMediumIdFromMedium < ActiveRecord::Migration
  def change
    remove_column :media, :medium_id, :integer
  end
end
