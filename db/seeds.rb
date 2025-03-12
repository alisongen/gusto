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
p ''
puts 'Restos supprimés 🎊'

puts 'Destruction des friendships 💥'
Friendship.destroy_all
p ''
puts 'Friendships supprimés 🎊'

puts 'Destruction des users 💥'
User.destroy_all
p ''
puts 'Users supprimés 🎊'
p ''
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

p
puts 'Création de 10 users 👨🏻‍🎨'
users = Array.new(10) do
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
  email: "admin@admin",
  password: "adminadmin",
  city: "Admin-city",
  username: "admin",
  first_name: "admin",
  last_name: "admin",
  )
  admin.save!
  puts '...'
  puts 'Finish the Admin ✅'

  p
  puts 'Création de 33 friendships 👨🏻‍🎨'
  30.times do
    users = User.all
    friendship = Friendship.new(
      user: users.sample,
      friend: users.sample
    )
    friendship.save! unless friendship.user == friendship.friend
  end



  puts '...'
  puts '...'
  puts '...'
  p
  puts 'Finished friendships ✅'

  puts "Les restaurants commencent à l'ID #{Restaurant.first.id}"
  puts "Les users commencent à l'ID #{User.first.id}"
  puts "L'ID de l'admin est #{admin.id}"
  puts "Les friendships commencent à l'ID #{Friendship.first.id}"
  puts "Les collections commencent à l'ID #{.first.id}"
