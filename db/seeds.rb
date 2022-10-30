# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# user
FactoryBot.create(
  :user
)

# cv
2.times do |_j|
  user = FactoryBot.create(
    :user
  )
  rand(2..6).times do |_i|
    FactoryBot.create(
      :cv,
      user: user,
      email: user.email,
      first_name: 'Sarah',
      last_name: 'Kane'
    )
  end
end
