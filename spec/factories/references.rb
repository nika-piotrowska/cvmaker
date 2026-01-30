FactoryBot.define do
  factory :reference do
    association :section
    company { Faker::Company.name }
    contact_person { Faker::Name.name }
    phone_number { Faker::Number.number(digits: 9) }
    email { Faker::Internet.email }
    position { 1 }
  end
end
