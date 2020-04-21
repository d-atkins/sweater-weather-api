FactoryBot.define do
  factory :user do
    email { "factory.bot.user@example.com" }
    password { "burgers" }
    password_confirmation { "burgers" }
    api_key { "123" }
  end
end
