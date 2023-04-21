FactoryBot.define do
  factory :comment do
    association :user
    association :board
    message { "Hello" }
  end
end
