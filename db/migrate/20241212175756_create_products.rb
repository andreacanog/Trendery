class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.decimal :price, null: false, precision: 10, scale: 2
      t.integer :stock, null: false, default: 0

      t.timestamps
    end
  end
end
