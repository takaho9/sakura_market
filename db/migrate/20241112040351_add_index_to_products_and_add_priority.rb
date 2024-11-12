class AddIndexToProductsAndAddPriority < ActiveRecord::Migration[7.2]
  def change
    add_column :products, :priority, :integer, default: 0, null: false

    add_index :products, :price
    add_index :products, :created_at
    add_index :products, :priority
  end
end
