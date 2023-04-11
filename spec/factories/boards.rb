FactoryBot.define do
  factory :board do
    association :user
    title { "MyString" }
    img { "MyString" }
    description { "MyString" }
  end
end
