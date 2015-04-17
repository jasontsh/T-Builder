class CreateCharacteristics < ActiveRecord::Migration
  def change
    create_table :characteristics do |t|
      t.string :name
      t.integer :value

      t.timestamps
    end
  end
end
