FactoryBot.define do
  factory :comment do
    board { nil }
    user { nil }
    message { "MyString" }
  end
end
