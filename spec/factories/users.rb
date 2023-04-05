FactoryBot.define do
  factory :user do
    name { "テスト太郎" }
    sequence :email do |n|
        "test#{n}@example.com"
    end
    password { "Password2023" }
    password_confirmation { "Password2023" }
  end
end
