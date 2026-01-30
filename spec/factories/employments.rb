FactoryBot.define do
  factory :employment do
    association :section
    name { Faker::Job.title }
    city { Faker::Address.city }
    employer { Faker::Company.name }
    start_date { Faker::Date.backward(days: 1000) }
    end_date { Faker::Date.forward(days: 1000) }
    position { 1 }
  end
end
