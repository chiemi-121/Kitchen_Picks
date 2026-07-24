FactoryBot.define do
  factory :admin do
    sequence(:login_id) { |n| "admin#{n}" }
    sequence(:email) { |n| "admin#{n}@example.com" }
    password { "password" }
  end
end
