class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

belongs_to :category
belongs_to :brand
belongs_to_active_hash :condition
belongs_to_active_hash :fee_burden
belongs_to_active_hash :prefecture
belongs_to_active_hash :size
belongs_to_active_hash :shipping_days
belongs_to_active_hash :sipping_method

end
