class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.text :detail, null: false
      t.integer :price, null: false
      t.integer :brand_id, foreign_key: true
      t.integer :condition, null: false, foreign_key: true
      t.integer :fee_burden, null: false, foreign_key: true
      t.integer :prefecture, null: false, foreign_key: true
      t.integer :size, null: false, foreign_key: true
      t.integer :shipping_days, null: false, foreign_key: true
      t.integer :shipping_method, null: false, foreign_key: true
      t.integer :category_id, null: false, foreign_key: true
      t.integer :order_status, null: false
      t.integer :seller, null: false
      t.integer :buyer
      t.timestamps
    end
  end
end
