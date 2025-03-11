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
puts '...'
p
puts 'Finished ✅'
