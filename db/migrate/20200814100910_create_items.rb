class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.text :detail, null: false
      t.integer :price, null: false
      t.integer :brand_id
      t.integer :condition_id, null: false
      t.integer :fee_burden_id, null: false
      t.integer :prefecture_id, null: false
      t.integer :size_id
      t.integer :shipping_days_id, null: false
      t.integer :shipping_method_id, null: false
      t.references :category, foreign_key: true
      t.text :order_status, null:false
      t.integer :seller, null: false
      t.integer :buyer
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end