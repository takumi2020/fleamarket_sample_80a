FactoryBot.define do

  factory :item do
    name                    {"test"}
    detail                  {"aaaa"}
    price                   {3333}
    item_images_attributes  {[]}
    category
    brand_id                {1}
    size_id                 {1}
    condition_id            {1}
    fee_burden_id           {1}
    shipping_method_id      {1}
    shipping_days_id        {1}
    prefecture_id           {1}
    order_status            {"出品中"}
    seller                  {1}
    user
    after( :build ) do |item|
      item.item_images << FactoryBot.build(:item_image)
    end
  end

  factory :item_no_image, class: Item do
    name                    {"test"}
    detail                  {"aaaa"}
    price                   {3333}
    item_images_attributes  {[]}
    category
    brand_id                {1}
    size_id                 {1}
    condition_id            {1}
    fee_burden_id           {1}
    shipping_method_id      {1}
    shipping_days_id        {1}
    prefecture_id           {1}
    order_status            {"出品中"}
    seller                  {1}
    user
  end
end