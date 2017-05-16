# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 10.times do
#   User.create first_name: Faker::Name.first_name,
#             last_name: Faker::Name.last_name,
#             email: Faker::Internet.email,
#             password: "12345678",
#             password_confirmation: "12345678"
# end

# 10.times do
#   Auction.create title: Faker::Book.title,
#               details: Faker::Hipster.paragraph,
#               user: User.all.sample,
#               reserve_price: rand(1..2000),
#               ends_on: (Date.today + Faker::Number.number(2).to_i.days)
#
# end
20.times do
  Bid.create auction: Auction.all.sample,
              user: User.all.sample,
              price: rand(10..75)

end
puts 'data created'
