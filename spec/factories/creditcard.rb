FactoryBot.define do
  factory :creditcard do
    user_id               {1}
    card_number           {"1234567812341234"}
    card_company          {1}
    card_year             {"12"}
    card_month            {"20"}
    card_pass             {"123"}
  end
end
