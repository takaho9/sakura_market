class CreateOrders < ActiveRecord::Migration[7.2]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :total_price, null: false
      t.integer :cod_fee, comment: "代引き手数料"
      t.decimal :tax_rate, precision: 8, scale: 2, default: 0.0, null: false
      t.integer :shipping_fee, null: false, default: 0
      t.integer :status, null: false, default: 0
      t.string :postal_code, null: false
      t.string :address, null: false
      t.string :last_name, null: false
      t.string :first_name, null: false

      t.timestamps
    end
  end
end
