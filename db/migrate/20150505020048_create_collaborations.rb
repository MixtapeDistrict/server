class CreateCollaborations < ActiveRecord::Migration
  def change
    create_table :collaborations do |t|
      t.integer :first_id
      t.integer :second_id
      t.string :message

      t.timestamps
    end
  end
end
