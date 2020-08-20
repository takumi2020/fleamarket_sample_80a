FactoryBot.define do
  factory :user do
    nickname              {"ヤマ"}
    sequence(:email) { |n| "TEST#{n}@example.com" }
    password              {"aaaa111"}
    family_name            {"太郎"}
    last_name             {"山田"}
    family_name_kana       {"タロウ"}
    last_name_kana        {"ヤマダ"}
    birthday              {"1985-01-01"}
  end
end
