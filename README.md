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
|comment_id|references|null: false, foreign_key: true|
|item_id|references|null: false, foreign_key: true|
|adress_id|references|null: false, foreign_key: true|
|user_img|string|null: false, foreign_key: true|
### Association
- has_many :items
- has_many :comments
- has_many :addresses

## addressesテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false, foreign_key: true|
|postal_code|integer|null: false|
|prefecture_code|integer|null: false|
|city|string|null: false|
|house_number|string|null: false|
|building_name|string||
### Association
- belongs_to :user
- belongs_to_active_hash :prefecture_code


## itemsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|detail|text|null: false|
|price|integer|null: false|
|brand|references|foreign_key: true|
|condition|references|null: false,foreign_key: true|
|fee_burden|references|null: false,foreign_key: true|
|prefecture_code|integer|null: false|
|size|references|null: false,foreign_key: true|
|shipping_days|references|null: false,foreign_key: true|
|sipping_method|references|null: false,foreign_key: true|
|item_img|references|null: false,foreign_key: true|
|category|references|null: false,foreign_key: true|
|order_status|enum|null: false|
|seller|references|null: false,foreign_key: true|
|buyer|references|foreign_key: true|
### Association
- belongs_to :user
- belongs_to :lv1_category
- has_many :comments
- has_many :item_imgs
- belongs_to_active_hash :prefecture_code

## item_imgsテーブル
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

## lv1_categoriesテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null:false|
### Association
- has_many :items
- has_many :lv2_categories

## lv2_categoriesテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null:false|
|lv1_category_id|references|null: false, foreign_key: true|
### Association
- belongs_to :lv1_category
- has_many :lv3_categories

## lv3_categoriesテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null:false|
|lv2_category_id|references|null: false, foreign_key: true|
### Association
- belongs_to :lv2_category