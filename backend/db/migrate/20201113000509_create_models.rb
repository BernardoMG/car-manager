class CreateModels < ActiveRecord::Migration[6.0]
  def change
    create_table :models do |t|
      t.string :name, null: false
      t.belongs_to :maker, null: false

      t.timestamps
    end
  end
end
