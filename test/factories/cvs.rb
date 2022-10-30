FactoryBot.define do
  factory :cv do
    name { Faker::Creature::Dog.meme_phrase }
    first_name { Faker::Name.female_first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    phone_number { Faker::Number.number(digits: 9) }
    address { Faker::Address.full_address }
    drivers_licence { 'kat. B' }
    linkedin { Faker::Internet.domain_name(subdomain: true, domain: 'linkedin') }
    facebook { Faker::Internet.domain_name(subdomain: true, domain: 'facebook') }
    twitter { Faker::Internet.domain_name(subdomain: true, domain: 'twitter') }
    instagram { Faker::Internet.domain_name(subdomain: true, domain: 'instagram') }
    github { Faker::Internet.domain_name(subdomain: true, domain: 'github') }
    website { Faker::Internet.domain_name(subdomain: true, domain: 'website') }
    birth_date { Faker::Date.birthday(min_age: 18, max_age: 65) }
    sex { Cv.sexes[:female] }
  end
end
