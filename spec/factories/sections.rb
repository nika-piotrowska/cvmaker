FactoryBot.define do
  factory :section do
    association :cv
    name { :certificates_section }
    vertical_position { 1 }
    horizontal_position { :main_body }
  end
end
