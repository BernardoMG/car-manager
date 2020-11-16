class AddIndexesForCarsTable < ActiveRecord::Migration[6.0]
  def change
    add_index(:cars, :monthly, using: 'btree')
    add_index(:cars, :year, using: 'btree')
    add_index(:cars, :available_from, using: 'btree')
  end
end
