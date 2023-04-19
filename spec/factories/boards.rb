FactoryBot.define do
  factory :board do
    association :user
    title { "掲示板のタイトル" }
    img { "イメージ画像" }
    description { "掲示板の紹介文" }
  end
end
