class AddCharacteristicToUser < ActiveRecord::Migration
  def change
    add_column :users, :characteristic, :string
  end
end
