FactoryBot.define do
  factory :user do
    nickname              {"abe"}
    email                 {Faker::Internet.email}
    password              {"0000000"}
    password_confirmation {"0000000"}
    birthday              {"2020-01-01"}
    family_name            {"山田"}
    family_name_kana        {"ヤマダ"}
    last_name             {"太朗"}
    last_name_kana         {"タロウ"}
  end
end