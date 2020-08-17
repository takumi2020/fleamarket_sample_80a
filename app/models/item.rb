class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  has_many :item_images
  belongs_to :category
  belongs_to :brand
  belongs_to_active_hash :condition
  belongs_to_active_hash :fee_burden
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :size
  belongs_to_active_hash :shipping_days
  belongs_to_active_hash :shipping_method
  belongs_to :seller, class_name:"User"

  accepts_nested_attributes_for :item_images, allow_destroy: true
  accepts_nested_attributes_for :brand, allow_destroy: true

  validates_associated :item_images
  validates :item_images, presence: true

end
