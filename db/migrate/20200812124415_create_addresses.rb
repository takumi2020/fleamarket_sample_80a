class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.integer :prefecture_id, null: false, foreign_key: true
      t.string :city, null: false
      t.timestamps
    end
  end
end
