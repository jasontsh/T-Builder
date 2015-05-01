class AddCharacteristicToEvent < ActiveRecord::Migration
  def change
  	add_column :events, :characteristic, :string
  end
end
