FactoryBot.define do
  factory :education do
    association :section
    level { Faker::Educator.degree }
    city { Faker::Address.city }
    university { Faker::University.name }
    faculty { Faker::Educator.subject }
    specialisation { Faker::Educator.subject }
    start_date { Faker::Date.backward(days: 1000) }
    end_date { Faker::Date.forward(days: 1000) }
    position { 1 }
  end
end
