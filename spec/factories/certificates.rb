FactoryBot.define do
  factory :certificate do
    association :section
    name { Faker::Name.name }
    date { Faker::Date.backward(days: 365) }
    position { 1 }
  end
end
