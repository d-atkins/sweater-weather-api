FactoryBot.define do
  factory :user do
    email { "burgertime@example.com" }
    password_digest { "burgers" }
    api_key { "123" }
  end
end
