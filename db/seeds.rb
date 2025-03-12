require 'faker'
# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
puts 'Destruction des restos 💥'
Restaurant.destroy_all
p
puts 'Restos supprimés 🎊'
p
puts 'Création de 100 restaurants 👨🏻‍🎨'
100.times do
  restaurant = Restaurant.new(
    name: Faker::Restaurant.name,
    description: Faker::Restaurant.description,
    address: Faker::Address.full_address,
    category: Faker::Nation.nationality,
    menu: Faker::Internet.domain_name,
    rating: Faker::Number.within(range: 1..5),
    website: Faker::Internet.domain_name
  )
  Faker::Config.locale = 'fr'
  restaurant.phone_number = Faker::PhoneNumber.cell_phone_with_country_code
  restaurant.save!
end
p
puts '...'
puts '...'
puts '...'
puts 'Finished restos ✅'

puts 'Destruction des users 💥'
User.destroy_all
p
puts 'Users supprimés 🎊'
p
puts 'Création de 10 users 👨🏻‍🎨'
10.times do
  user = User.new(
    email: "#{Faker::Name.first_name}@#{Faker::Name.last_name}",
    password: Faker::Lorem.characters(number: 6),
    city: Faker::Address.city,
    username: Faker::FunnyName.name,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    )
    user.save!
  end

  p
  puts '...'
  puts '...'
  puts '...'
puts 'Finished users ✅'

puts "Création de l'admin 👨🏻‍🎨"

admin = User.new(
  email: "admin@gmail.com",
  password: "123456",
  city: "Admin-city",
  username: "admin",
  first_name: "admin",
  last_name: "admin",
  )
  admin.save!
  puts '...'
  puts 'Finish the Admin ✅'

puts 'Destruction des friendships 💥'
Friendship.destroy_all
p
puts 'Friendships supprimés 🎊'
p
puts 'Création de 5 friendships 👨🏻‍🎨'
5.times do
  friendship = Friendship.new(
    user_id: User.find
    t.bigint "user_id", null: false
    t.bigint "friend_id", null: false
  )
  friendship.save!
end

puts '...'
puts '...'
puts '...'
p
puts 'Finished friendships ✅'


