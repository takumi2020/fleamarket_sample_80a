FactoryBot.define do
  factory :item_image do
    url   {File.open("#{Rails.root}/spec/fixtures/test.jpeg")}
  end
end