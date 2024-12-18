class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.string :status, null: false, default: 'pending'
      t.decimal :total, null: false, precision: 10, scale: 2, default: 0.0

      t.timestamps
    end
  end
end
