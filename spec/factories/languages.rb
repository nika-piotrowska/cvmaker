FactoryBot.define do
  factory :language do
    association :section
    language { Faker::Nation.language }
    language_level { :a1 }
    position { 1 }
  end
end
