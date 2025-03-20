require 'faker'
require 'open-uri'

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# puts 'Destruction des saved_restos_collections 💥'
# SavedRestaurantsCollection.destroy_all
# puts 'Saved_restos supprimés 🎊'
# p ''

# puts 'Destruction des reviews 💥'
# Review.destroy_all
# puts 'Reviews supprimés 🎊'
# p ''

# puts 'Destruction des saved_restos 💥'
# SavedRestaurant.destroy_all
# puts 'Saved_restos supprimés 🎊'
# p ''

puts 'Destruction des restos 💥'
Restaurant.destroy_all
puts 'Restos supprimés 🎊'
p ''

puts 'Destruction des friendships 💥'
Friendship.destroy_all
puts 'Friendships supprimés 🎊'
p ''

# puts 'Destruction des collections 💥'
# Collection.destroy_all
# puts 'Collections supprimés 🎊'
# p ''

puts 'Destruction des users 💥'
User.destroy_all
puts 'Users supprimés 🎊'
p ''
puts 'Création de 10 restaurants 👨🏻‍🎨'

# COMMANDES POUR LA CONSOLE
# Cloudinary::Uploader.upload(Rails.root.join('app/assets/images/jason-leung-poI7DelFiVA-unsplash.jpg'))
# Cloudinary::Uploader.upload(Rails.root.join('app/assets/images/jay-wennington-N_Y88TWmGwA-unsplash.jpg'))
# Cloudinary::Uploader.upload(Rails.root.join('app/assets/images/nick-karvounis-Ciqxn7FE4vE-unsplash.jpg'))
# Cloudinary::Uploader.upload(Rails.root.join('app/assets/images/volkan-vardar-1H30uRC1plc-unsplash.jpg'))


images = Dir.glob("app/assets/images/*.jpg").first(10)
10.times do |i|

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
  image_url = Cloudinary::Uploader.upload(images[i])['url']
  image = URI.parse(image_url).open
  restaurant.images.attach(io: image, filename: "#{restaurant.name.parameterize}.jpg", content_type: "image/jpg")
  restaurant.save!

  puts "#{restaurant.name} created"
end

puts "photo uploadés sur cloudinary ✅"

puts '...'
puts '...'
puts '...'
puts 'Finished restos ✅'

puts 'Création de 10 users 👨🏻‍🎨'
users = Array.new(10) do
  user = User.new(
    email: "#{Faker::Name.first_name}@gmail.com",
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
p ''
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
puts "Création de l'gautier 👨🏻‍🎨"

gautier = User.new(
  email: "gautier@gautier",
  password: "gautiergautier",
  city: "gautier-city",
  username: "gautier",
  first_name: "gautier",
  last_name: "gautier",
  )
  gautier.save!
  puts '...'
  puts 'Finish the gautier ✅'
puts "Création de l'gil 👨🏻‍🎨"

gil = User.new(
  email: "gil@gil",
  password: "gilgil",
  city: "gil-city",
  username: "gil",
  first_name: "gil",
  last_name: "gil",
  )
  gil.save!
  puts '...'
  puts 'Finish the gil ✅'
puts "Création de l'alison 👨🏻‍🎨"

alison = User.new(
  email: "alison@alison",
  password: "alisonalison",
  city: "alison-city",
  username: "alison",
  first_name: "alison",
  last_name: "alison",
  )
  alison.save!
  puts '...'
  puts 'Finish the alison ✅'
puts "Création de l'bruno 👨🏻‍🎨"

bruno = User.new(
  email: "bruno@bruno",
  password: "brunobruno",
  city: "bruno-city",
  username: "bruno",
  first_name: "bruno",
  last_name: "bruno",
  )
  bruno.save!
  puts '...'
  puts 'Finish the bruno ✅'

  p ''
  puts 'Création de 100 friendships 👨🏻‍🎨'
  100.times do
    users = User.all
    user = users.sample
    friend = users.sample
    unless user == friend || Friendship.exists?(user: user, friend: friend) || Friendship.exists?(user: friend, friend: user)
      Friendship.create!(user: user, friend: friend)
    end
  end



puts '...'
puts '...'
puts '...'
p
puts 'Finished friendships ✅'
p ''
puts 'Création de 5 collections pour chaque User 👨🏻‍🎨'
collections = ['A tester', 'Trop bon le soir', 'Date', 'Bon brunch', 'Favoris' ]
emojis = [ "🍔", "🥞", "🧁", "🍣", "☕️", "🥗", "🍻", "🥩", "🌯", "💙", "🎉", "🍽️" ]
colors = [
      "#4B3B47", # Eggplant
      "#FFBD33", # Orange
      "#FFD133", # Yellow
      "#A3E635", # Lime Green
      "#33FF57", # Green
      "#33FFBD", # Mint
      "#33D1FF", # Sky Blue
      "#3357FF", # Blue
      "#8A33FF", # Purple
      "#FF33F0", # Pink
      "#FF3380", # Hot Pink
      "#FF3366"  # Red
    ]
users = User.all
users.each do |user|
  collections.each do |collection|
    Collection.create!(
      name: collection,
      user: user,
      emoji: emojis.sample,
      color: colors.sample
      )
    end
  end

puts 'Finished collections ✅'
p ''
puts 'Création de 5 saved_restos pour chaque User 👨🏻‍🎨'
restaurants = Restaurant.all
users.each do |user|
  saved_restaurants = []
  5.times do
    restaurant = restaurants.sample
    unless SavedRestaurant.exists?(user: user, restaurant: restaurant)
      saved_restaurant = SavedRestaurant.create!(user: user, restaurant: restaurant)
      saved_restaurants << saved_restaurant
    end
  end
  user_collections = user.collections
  saved_restaurants.each_with_index do |saved_restaurant, index|
    collection = user_collections[index % user_collections.size]
    SavedRestaurantsCollection.create!(collection: collection, saved_restaurant: saved_restaurant)
  end
end

puts 'Finished saved_restos ✅'
p ''

puts 'Création de 10 reviews pour chaque User 👨🏻‍🎨'
users.each do |user|
  10.times do
    saved_restaurant = user.saved_restaurants.sample
    Review.create!(
      content: Faker::Restaurant.review,
      user_rating: Faker::Number.within(range: 1..5),
      user: user,
      saved_restaurant: saved_restaurant
    )
  end
end

puts 'Finished reviews ✅'
p ''

puts "Les restaurants commencent à l'ID #{Restaurant.first.id}"
puts "Les users commencent à l'ID #{User.first.id}"
puts "L'ID de l'admin est #{admin.id}"
puts "Les friendships commencent à l'ID #{Friendship.first.id}"
puts "Les collections commencent à l'ID #{Collection.first.id}"
puts "Les saved_restos commencent à l'ID #{SavedRestaurant.first.id}"
puts "Les saved_restos_collection commencent à l'ID #{SavedRestaurantsCollection.first.id}"
puts "Les reviews commencent à l'ID #{Review.first.id}"
