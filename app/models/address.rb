class Address < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  belongs_to :user, optional: true


  validates :prefecture_id, :city, :house_number, presence: true
  validates :tell, presence: false
  validates :postal_code, presence: true, format: { with: /\A\d{7}\z/ }  #ハイフンなし7桁

end
