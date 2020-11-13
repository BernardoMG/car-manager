class CreateCars < ActiveRecord::Migration[6.0]
  def change
    create_table :cars do |t|
      t.date :available_from, null: false
      t.integer :year, null: false
      t.decimal :monthly, null: false
      t.belongs_to :color, null: false
      t.belongs_to :model, null: false
      t.belongs_to :maker, null: false

      t.timestamps
    end
  end
end
