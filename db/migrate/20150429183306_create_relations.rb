class CreateRelations < ActiveRecord::Migration
  def change
    create_table :relations do |t|
      t.integer :userid
      t.integer :eventid

      t.timestamps
    end
  end
end
