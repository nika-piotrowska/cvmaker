FactoryBot.define do
  sequence(:email) { |n| "user#{n}@user.com" }

  factory :user do
    email { generate(:email) }
    password { 'Password!' }
  end
end
