class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.text :detail, null: false
      t.integer :price, null: false
      t.integer :brand_id, foreign_key: true
      t.integer :condition_id, null: false, foreign_key: true
      t.integer :fee_burden_id, null: false, foreign_key: true
      t.integer :prefecture_id, null: false, foreign_key: true
      # t.integer :size_id, null: false, foreign_key: true
      t.integer :shipping_days_id, null: false, foreign_key: true
      # t.integer :shipping_method_id, null: false, foreign_key: true
      # t.integer :category_id, null: false, foreign_key: true
      # t.integer :order_status, null: false
      # t.integer :seller, null: false
      # t.integer :buyer
      t.timestamps
    end
  end
end
