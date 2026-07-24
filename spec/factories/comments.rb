FactoryBot.define do
  factory :comment do
    association :post
    association :user
    body { "テストコメント" }
  end
end
