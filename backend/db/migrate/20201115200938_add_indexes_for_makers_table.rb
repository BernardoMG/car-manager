class AddIndexesForMakersTable < ActiveRecord::Migration[6.0]
  def change
    add_index(:makers, :name, using: 'btree')
  end
end
