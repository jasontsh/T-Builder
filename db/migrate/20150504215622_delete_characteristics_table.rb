class DeleteCharacteristicsTable < ActiveRecord::Migration
  def change
  	drop_table :characteristics
  end
end
