FactoryBot.define do
  factory :relationship do
    association :following, factory: :user
    association :follower, factory: :user
  end
end
