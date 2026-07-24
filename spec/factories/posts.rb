FactoryBot.define do
  factory :post do
    association :user
    association :category
    title { "テスト投稿" }
    body  { "本文" }
    rating { 3 }
  end
end