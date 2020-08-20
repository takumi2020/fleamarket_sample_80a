FactoryBot.define do
  factory :address do
    postal_code      {"1234567"}
    prefecture_id       {2}
    city             {"札幌市"}
    house_number     {"青葉区1-1-1"}
    building_name    {"柳ビル101"}
    tell             {"09011112222"}
  end
end