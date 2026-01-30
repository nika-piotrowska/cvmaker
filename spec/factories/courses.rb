FactoryBot.define do
  factory :course do
    association :section
    name { Faker::Educator.course_name }
    institution { Faker::University.name }
    start_date { Faker::Date.backward(days: 365) }
    end_date { Faker::Date.forward(days: 365) }
    position { 1 }
  end
end
