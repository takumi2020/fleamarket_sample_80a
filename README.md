# freemarket_sample DB設計

## usersテーブル
|Column|Type|Options|
|------|----|-------|
|nickname|string|null :false|
|mail|string|null: false, unique: true, index: true|
|password|string|null: false|
|family_name|string|null: false|
|first_name|string|null: false|
|family_name_kana|string|null: false|
|first_name_kana|string|null: false|
|birthday|date|null: false|
|tell|integer|unique: true|
|introduction|text||
|user_img|string|null: false, foreign_key: true|
### Association
- has_many :items
- has_many :comments
- has_one :address
- has_many :seller_items, foreign_key: "seller_id", class_name: "items"
- has_many :buyer_items, foreign_key: "buyer_id", class_name: "items"

## addressesテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false, foreign_key: true|
|postal_code|integer|null: false|
|prefecture|integer|null: false|
|city|string|null: false|
|house_number|string|null: false|
|building_name|string||
### Association
- belongs_to :user
- belongs_to_active_hash :prefecture


## itemsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|detail|text|null: false|
|price|integer|null: false|
|brand|references|foreign_key: true|
|condition|references|null: false,foreign_key: true|
|fee_burden|references|null: false,foreign_key: true|
|prefecture|integer|null: false|
|size|references|null: false,foreign_key: true|
|shipping_days|references|null: false,foreign_key: true|
|sipping_method|references|null: false,foreign_key: true|
|category|references|null: false,foreign_key: true|
|order_status|enum|null: false|
|seller|references|null: false,foreign_key: true|
|buyer|references|foreign_key: true|
### Association
- has_many :comments
- has_many :item_images
- belongs_to :user
- belongs_to :category
- belongs_to :brand
- belongs_to_active_hash :condition
- belongs_to_active_hash :fee_burden
- belongs_to_active_hash :prefecture
- belongs_to_active_hash :size
- belongs_to_active_hash :shipping_days
- belongs_to_active_hash :sipping_method
- belongs_to :seller, class_name:"User"
- belongs_to :buyer, class_name:"User"

## item_imagesテーブル
|Column|Type|Options|
|------|----|-------|
|url|string|null:false|
|item_id|references|null: false, foreign_key: true|
### Association
- belongs_to :item

## commentsテーブル
|Column|Type|Options|
|------|----|-------|
|content|text|null: false|
|user_id|references|null: false, foreign_key: true|
|item_id|references|null: false, foreign_key: true|
### Association
- belongs_to :user
- belongs_to :item

## categoriesテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null:false|
|ancestry|string|null:false|
### Association
- has_many :items

## brandsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string||
### Association
- has_many :items