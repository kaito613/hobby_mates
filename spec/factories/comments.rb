FactoryBot.define do
  factory :comment do
    association :user
    association :board
    message { "MyString" }
  end
end
