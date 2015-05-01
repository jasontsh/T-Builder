class AddStatusToRelations < ActiveRecord::Migration
  def change
  	add_column :relations, :status, :integer
  end
end
