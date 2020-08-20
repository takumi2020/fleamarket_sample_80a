class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  has_many :item_images, dependent: :destroy
  belongs_to :user
  belongs_to :category
  belongs_to_active_hash :brand
  belongs_to_active_hash :condition
  belongs_to_active_hash :fee_burden
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :size
  belongs_to_active_hash :shipping_days
  belongs_to_active_hash :shipping_method

  accepts_nested_attributes_for :item_images, allow_destroy: true
  accepts_nested_attributes_for :brand, allow_destroy: true

  validates_associated :item_images
  validates :item_images, presence: true
  validates :name, :detail, :category, :condition_id, :fee_burden_id, :shipping_method_id, :prefecture_id, :shipping_days_id, :seller, presence: true
  validates :price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 100, less_than_or_equal_to: 9999999 }

  has_many :comments, dependent: :destroy

end
