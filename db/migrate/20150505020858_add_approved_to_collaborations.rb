class AddApprovedToCollaborations < ActiveRecord::Migration
  def change
    add_column :collaborations, :approved, :boolean
  end
end
