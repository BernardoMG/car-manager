class CreateModelColors < ActiveRecord::Migration[6.0]
  def change
    create_table :model_colors do |t|
      t.references :model, null: false, foreign_key: true
      t.references :color, null: false, foreign_key: true

      t.timestamps
    end
  end
end
