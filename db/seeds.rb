require 'faker'
require 'open-uri'

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
puts 'Création de restaurants 👨🏻‍🎨'

# COMMANDES POUR LA CONSOLE
# Cloudinary::Uploader.upload(Rails.root.join('app/assets/images/jason-leung-poI7DelFiVA-unsplash.jpg'))
# Cloudinary::Uploader.upload(Rails.root.join('app/assets/images/jay-wennington-N_Y88TWmGwA-unsplash.jpg'))
# Cloudinary::Uploader.upload(Rails.root.join('app/assets/images/nick-karvounis-Ciqxn7FE4vE-unsplash.jpg'))
# Cloudinary::Uploader.upload(Rails.root.join('app/assets/images/volkan-vardar-1H30uRC1plc-unsplash.jpg'))


# images = Dir.glob("app/assets/images/*.jpg").first(10)
# 10.times do |i|

#   restaurant = Restaurant.new(
#     name: Faker::Restaurant.name,
#     description: Faker::Restaurant.description,
#     address: Faker::Address.full_address,
#     category: Faker::Nation.nationality,
#     menu: Faker::Internet.domain_name,
#     rating: Faker::Number.within(range: 1..5),
#     website: Faker::Internet.domain_name
#   )

#   Faker::Config.locale = 'fr'
#   restaurant.phone_number = Faker::PhoneNumber.cell_phone_with_country_code

#   image_url = Cloudinary::Uploader.upload(images[i])['url']
#   image = URI.parse(image_url).open
#   restaurant.images.attach(io: image, filename: "#{restaurant.name.parameterize}.jpg", content_type: "image/jpg")
#   restaurant.save!

#   puts "#{restaurant.name} created"
# end

images = Dir.glob("app/assets/images/restau/*.jpg").first(30)

restaurants = [
  { name: "Septime", description: "Cuisine française gastronomique avec des produits locaux et de saison.", address: "80 Rue de Charonne, 75011 Paris", category: "Gastronomique", menu: "Menu dégustation 7 plats", rating: 4.8, website: "https://www.septime-charonne.fr", phone_number: "+33 1 43 67 38 29" },
  { name: "Le Procope", description: "Le plus ancien café de Paris, proposant une cuisine traditionnelle française.", address: "13 Rue de l'Ancienne Comédie, 75006 Paris", category: "Bistrot", menu: "Coq au vin, escargots, crème brûlée", rating: 4.2, website: "https://www.procope.com", phone_number: "+33 1 40 46 79 00" },
  { name: "Frenchie", description: "Cuisine inventive et moderne dans un cadre convivial.", address: "5-6 Rue du Nil, 75002 Paris", category: "Bistronomique", menu: "Filet de veau rôti, légumes de saison", rating: 4.6, website: "https://www.frenchie-restaurant.com", phone_number: "+33 1 40 39 96 19" },
  { name: "Clamato", description: "Petit restaurant de fruits de mer branché, annexe de Septime.", address: "80 Rue de Charonne, 75011 Paris", category: "Poisson", menu: "Huîtres, ceviche, tarte aux noix de pécan", rating: 4.4, website: "https://www.clamato-charonne.fr", phone_number: "+33 1 43 72 74 53" },
  { name: "Le Train Bleu", description: "Restaurant historique à la Gare de Lyon, cuisine française raffinée.", address: "Place Louis-Armand, 75012 Paris", category: "Traditionnel", menu: "Ris de veau, tournedos Rossini", rating: 4.5, website: "https://www.le-train-bleu.com", phone_number: "+33 1 43 43 09 06" },
  { name: "Big Mamma", description: "Cuisine italienne généreuse avec des ingrédients frais.", address: "20 Bis Rue de Douai, 75009 Paris", category: "Italien", menu: "Pizza à la truffe, pasta al tartufo", rating: 4.7, website: "https://www.bigmammagroup.com", phone_number: "+33 1 42 65 31 36" },
  { name: "Chez L'Ami Jean", description: "Cuisine basque authentique dans un cadre rustique.", address: "27 Rue Malar, 75007 Paris", category: "Bistrot", menu: "Paleron de bœuf, riz au lait", rating: 4.3, website: "https://www.chezlamijean.fr", phone_number: "+33 1 47 05 86 89" },
  { name: "Pierre Gagnaire", description: "Cuisine d'auteur avec des associations de saveurs originales.", address: "6 Rue Balzac, 75008 Paris", category: "Gastronomique", menu: "Menu dégustation, créations uniques", rating: 4.9, website: "https://www.pierre-gagnaire.com", phone_number: "+33 1 58 36 12 50" },
  { name: "Bouillon Pigalle", description: "Cuisine française traditionnelle à petits prix.", address: "22 Boulevard de Clichy, 75018 Paris", category: "Brasserie", menu: "Œufs mayonnaise, bœuf bourguignon", rating: 4.1, website: "https://www.bouillonpigalle.com", phone_number: "+33 1 42 59 69 31" },
  { name: "Pink Mamma", description: "Cuisine italienne dans un cadre unique avec rooftop.", address: "20 Bis Rue de Douai, 75009 Paris", category: "Italien", menu: "Pizza Diavola, pasta carbonara", rating: 4.7, website: "https://www.bigmammagroup.com", phone_number: "+33 1 42 55 27 97" },
  { name: "Les Enfants Perdus", description: "Bistrot moderne avec une ambiance cosy.", address: "9 Rue des Récollets, 75010 Paris", category: "Bistrot", menu: "Tartare de bœuf, frites maison", rating: 4.4, website: "https://www.lesenfantsperdus.com", phone_number: "+33 1 81 29 48 82" },
  { name: "Le Clown Bar", description: "Cuisine inventive dans un cadre coloré et vintage.", address: "114 Rue Amelot, 75011 Paris", category: "Gastronomique", menu: "Tartelette au foie gras", rating: 4.5, website: "https://www.leclownbar.com", phone_number: "+33 1 43 55 87 35" },
  { name: "Hero", description: "Cuisine coréenne moderne et savoureuse.", address: "289 Rue Saint-Denis, 75002 Paris", category: "Coréen", menu: "Poulet frit épicé, bibimbap", rating: 4.5, website: "https://www.hero-paris.com", phone_number: "+33 1 23 45 67 89" },
  { name: "La Poule au Pot", description: "Cuisine française traditionnelle depuis 1935.", address: "9 Rue Vauvilliers, 75001 Paris", category: "Traditionnel", menu: "Poule au pot, gratin dauphinois", rating: 4.2, website: "https://www.lapouleaupot.com", phone_number: "+33 1 42 36 32 96" },
  { name: "Bollynan", description: "Cuisine indienne avec pain naan fait maison.", address: "12 Rue des Petits Carreaux, 75002 Paris", category: "Indien", menu: "Poulet tikka masala, naan fromage", rating: 4.3, website: "https://www.bollynan.com", phone_number: "+33 1 45 08 21 31" },
  { name: "L'Avant Comptoir", description: "Bar à tapas français avec des produits frais et locaux.", address: "3 Carrefour de l'Odéon, 75006 Paris", category: "Tapas", menu: "Croquettes de jambon, tartare de bœuf", rating: 4.5, website: "https://www.lavantcomptoir.com", phone_number: "+33 1 44 27 07 97" },
  { name: "Le Bon Georges", description: "Bistrot parisien avec des viandes de qualité.", address: "45 Rue Saint-Georges, 75009 Paris", category: "Bistrot", menu: "Côte de bœuf, pommes de terre fondantes", rating: 4.7, website: "https://www.lebongeorges.com", phone_number: "+33 1 48 78 40 30" },
  { name: "Yard", description: "Cuisine de saison dans un cadre industriel.", address: "6 Rue de Mont-Louis, 75011 Paris", category: "Bistrot", menu: "Ragoût d'agneau, légumes racines", rating: 4.3, website: "https://www.yardparis.com", phone_number: "+33 1 40 09 70 30" },
  { name: "Astier", description: "Cuisine française traditionnelle et généreuse.", address: "44 Rue Jean-Pierre Timbaud, 75011 Paris", category: "Traditionnel", menu: "Blanquette de veau, plateau de fromages", rating: 4.6, website: "https://www.astier-paris.com", phone_number: "+33 1 43 57 16 35" },
  { name: "Le Timbre", description: "Petit bistrot avec une cuisine française raffinée.", address: "3 Rue Sainte-Beuve, 75006 Paris", category: "Bistrot", menu: "Poulet fermier rôti, gratin de légumes", rating: 4.4, website: "https://www.letimbreparis.com", phone_number: "+33 1 45 49 10 40" },
  { name: "Le Dauphin", description: "Cuisine inventive et tapas dans un cadre moderne.", address: "131 Avenue Parmentier, 75011 Paris", category: "Gastronomique", menu: "Foie gras aux figues, tartare de poisson", rating: 4.3, website: "https://www.ledauphinparis.com", phone_number: "+33 1 55 28 78 88" },
  { name: "Café de Flore", description: "Café légendaire de Saint-Germain-des-Prés.", address: "172 Boulevard Saint-Germain, 75006 Paris", category: "Café", menu: "Croque-monsieur, chocolat chaud", rating: 4.1, website: "https://www.cafedeflore.fr", phone_number: "+33 1 45 48 55 26" },
  { name: "Le Relais de l'Entrecôte", description: "Restaurant spécialisé dans l'entrecôte et sa sauce secrète.", address: "15 Rue Marbeuf, 75008 Paris", category: "Brasserie", menu: "Entrecôte-frites, salade verte", rating: 4.2, website: "https://www.relaisentrecote.fr", phone_number: "+33 1 49 52 07 17" },
  { name: "Au Passage", description: "Bistrot contemporain avec cuisine de marché.", address: "1 bis Passage Saint-Sébastien, 75011 Paris", category: "Bistrot", menu: "Tapenade maison, bœuf mariné", rating: 4.5, website: "https://www.aupassage.fr", phone_number: "+33 1 43 55 07 52" },
  { name: "Jaja", description: "Cuisine française dans un cadre moderne et décontracté.", address: "3 Rue Sainte-Croix de la Bretonnerie, 75004 Paris", category: "Bistronomique", menu: "Magret de canard, légumes grillés", rating: 4.3, website: "https://www.jajaparis.com", phone_number: "+33 1 42 74 71 52" },
  { name: "Breizh Café", description: "Crêperie bretonne avec un large choix de galettes.", address: "109 Rue Vieille du Temple, 75003 Paris", category: "Crêperie", menu: "Galette complète, crêpe caramel beurre salé", rating: 4.6, website: "https://www.breizhcafe.com", phone_number: "+33 1 42 72 13 77" },
  { name: "Le Petit Cambodge", description: "Cuisine cambodgienne authentique et savoureuse.", address: "20 Rue Alibert, 75010 Paris", category: "Asiatique", menu: "Bobun bœuf, nouilles sautées", rating: 4.5, website: "https://www.lepetitcambodge.com", phone_number: "+33 1 53 19 70 76" },
  { name: "Dersou", description: "Cuisine fusion avec des cocktails signatures.", address: "21 Rue Saint-Nicolas, 75012 Paris", category: "Fusion", menu: "Tataki de thon, cocktails épicés", rating: 4.6, website: "https://www.dersouparis.com", phone_number: "+33 1 43 02 21 58" },
  { name: "Le Mary Celeste", description: "Bar à huîtres avec des cocktails originaux.", address: "1 Rue Commines, 75003 Paris", category: "Poisson", menu: "Huîtres fraîches, ceviche de daurade", rating: 4.4, website: "https://www.lemaryceleste.com", phone_number: "+33 9 80 72 98 83" },
  { name: "La Bourse et La Vie", description: "Cuisine française classique revisitée.", address: "12 Rue Vivienne, 75002 Paris", category: "Bistronomique", menu: "Pot-au-feu, tarte aux pommes", rating: 4.7, website: "https://www.labourselavie.com", phone_number: "+33 1 42 60 08 83" },

  { name: "Candelaria", description: "Bar à cocktails caché avec des tacos mexicains.", address: "52 Rue de Saintonge, 75003 Paris", category: "Mexicain", menu: "Tacos carnitas, guacamole maison", rating: 4.4, website: "https://www.candelariaparis.com", phone_number: "+33 1 42 74 41 28" },
  { name: "Bones", description: "Cuisine inventive dans un cadre brut et industriel.", address: "43 Rue Godefroy Cavaignac, 75011 Paris", category: "Gastronomique", menu: "Cochon rôti, légumes de saison", rating: 4.6, website: "https://www.bonesparis.com", phone_number: "+33 1 40 09 03 70" },
  { name: "La Rotonde Stalingrad", description: "Brasserie et bar dans un bâtiment historique.", address: "6-8 Place de la Bataille de Stalingrad, 75019 Paris", category: "Brasserie", menu: "Planche de charcuterie, burger maison", rating: 4.3, website: "https://www.larotonde.com", phone_number: "+33 1 80 48 33 40" },
  { name: "Restaurant Guy Savoy", description: "Cuisine française haut de gamme avec trois étoiles Michelin.", address: "Monnaie de Paris, 11 Quai de Conti, 75006 Paris", category: "Gastronomique", menu: "Soupe d'artichaut à la truffe, brioche feuilletée", rating: 4.9, website: "https://www.guysavoy.com", phone_number: "+33 1 43 80 40 61" },
  { name: "L'Arpège", description: "Cuisine gastronomique centrée sur les légumes et les produits frais.", address: "84 Rue de Varenne, 75007 Paris", category: "Gastronomique", menu: "Légumes rôtis, agneau de lait", rating: 4.8, website: "https://www.alain-passard.com", phone_number: "+33 1 47 05 09 06" },
  { name: "Le Meurice", description: "Restaurant étoilé dans un cadre somptueux.", address: "228 Rue de Rivoli, 75001 Paris", category: "Gastronomique", menu: "Homard bleu, volaille de Bresse", rating: 4.9, website: "https://www.lemeurice.com", phone_number: "+33 1 44 58 10 55" },
  { name: "Le Cinq", description: "Cuisine gastronomique française dans un palace parisien.", address: "31 Avenue George V, 75008 Paris", category: "Gastronomique", menu: "Sole meunière, langoustines", rating: 4.9, website: "https://www.fourseasons.com", phone_number: "+33 1 49 52 71 54" },
  { name: "Septime La Cave", description: "Bar à vins avec des petits plats gourmands.", address: "3 Rue Basfroi, 75011 Paris", category: "Bar", menu: "Planche de charcuterie, fromage affiné", rating: 4.6, website: "https://www.septime-lacave.fr", phone_number: "+33 1 43 67 14 87" },
  { name: "Le Perchoir", description: "Rooftop branché avec une vue panoramique sur Paris.", address: "14 Rue Crespin du Gast, 75011 Paris", category: "Rooftop", menu: "Cocktails maison, tapas variés", rating: 4.5, website: "https://www.leperchoir.fr", phone_number: "+33 1 48 06 18 48" },
  { name: "Chez Janou", description: "Bistrot provençal avec une ambiance conviviale et cuisine du Sud.", address: "2 Rue Roger Verlomme, 75003 Paris", category: "Bistrot", menu: "Daube provençale, mousse au chocolat maison", rating: 4.4, website: "https://www.chezjanou.com", phone_number: "+33 1 42 72 28 41" },
  { name: "Le Georges", description: "Restaurant panoramique au sommet du Centre Pompidou.", address: "19 Rue Beaubourg, 75004 Paris", category: "Rooftop", menu: "Risotto aux champignons, tartare de thon", rating: 4.2, website: "https://www.restaurantgeorgesparis.com", phone_number: "+33 1 44 78 47 99" },
  { name: "Le Grand Colbert", description: "Brasserie classique avec une décoration Art Déco.", address: "2 Rue Vivienne, 75002 Paris", category: "Brasserie", menu: "Choucroute de la mer, entrecôte grillée", rating: 4.4, website: "https://www.legrandcolbert.fr", phone_number: "+33 1 42 86 87 88" },
  { name: "Le Coq Rico", description: "Restaurant spécialisé dans la volaille rôtie.", address: "98 Rue Lepic, 75018 Paris", category: "Bistronomique", menu: "Poulet rôti fermier, pommes grenailles", rating: 4.5, website: "https://www.lecoqrico.com", phone_number: "+33 1 42 59 82 89" }
]

restaurants.each do |restaurant_data|
  restaurant = Restaurant.new(
    name: restaurant_data[:name],
    description: restaurant_data[:description],
    address: restaurant_data[:address],
    category: restaurant_data[:category],
    menu: restaurant_data[:menu],
    rating: restaurant_data[:rating],
    website: restaurant_data[:website],
    phone_number: restaurant_data[:phone_number]
  )

  image_url = Cloudinary::Uploader.upload(images.sample)['url']
  image = URI.parse(image_url).open
  restaurant.images.attach(io: image, filename: "#{restaurant.name.parameterize}.jpg", content_type: "image/jpg")
  restaurant.save!

  puts "Restaurant '#{restaurant.name}' ✅"
end

puts '...'
puts 'Finished restos ✅'

p '------'

puts 'Création de users 👨🏻‍🎨'

# users = Array.new(10) do
#   user = User.new(
#     email: "#{Faker::Name.first_name}@gmail.com",
#     password: Faker::Lorem.characters(number: 6),
#     city: Faker::Address.city,
#     username: Faker::FunnyName.name,
#     first_name: Faker::Name.first_name,
#     last_name: Faker::Name.last_name,
#     )
#     user.save!
#   end

users = [
  { email: "thomas.dupont@gmail.com", password: "password123", city: "Paris", username: "thomdup", first_name: "Thomas", last_name: "Dupont" },
  { email: "marie.lefebvre@yahoo.fr", password: "password456", city: "Versailles", username: "marielef", first_name: "Marie", last_name: "Lefebvre" },
  { email: "paul.martin@outlook.fr", password: "password789", city: "Boulogne-Billancourt", username: "paulmart", first_name: "Paul", last_name: "Martin" },
  { email: "lucie.robert@protonmail.com", password: "securepass", city: "Neuilly-sur-Seine", username: "lucierob", first_name: "Lucie", last_name: "Robert" },
  { email: "jean.morel@gmail.com", password: "123456", city: "Montreuil", username: "jeanmor", first_name: "Jean", last_name: "Morel" },
  { email: "juliette.bernard@wanadoo.fr", password: "juliette123", city: "Saint-Denis", username: "julbern", first_name: "Juliette", last_name: "Bernard" },
  { email: "arnaud.petit@orange.fr", password: "petitpass", city: "Nanterre", username: "arnopet", first_name: "Arnaud", last_name: "Petit" },
  { email: "camille.dupuis@gmail.com", password: "camdup456", city: "Asnières-sur-Seine", username: "camdup", first_name: "Camille", last_name: "Dupuis" },
  { email: "florent.renard@gmail.com", password: "flo1234", city: "Cergy", username: "florenard", first_name: "Florent", last_name: "Renard" },
  { email: "aurelie.marchand@laposte.net", password: "marchandpass", city: "Argenteuil", username: "aurelmar", first_name: "Aurélie", last_name: "Marchand" },
  { email: "morgan.durand@hotmail.fr", password: "durandpass", city: "Créteil", username: "morgandur", first_name: "Morgan", last_name: "Durand" },
  { email: "thibaut.roux@yahoo.com", password: "rouxpass", city: "Vitry-sur-Seine", username: "thibroux", first_name: "Thibaut", last_name: "Roux" },
  { email: "lea.faure@orange.fr", password: "faure123", city: "Courbevoie", username: "leafau", first_name: "Léa", last_name: "Faure" },
  { email: "yann.vidal@protonmail.com", password: "vidalpass", city: "Rueil-Malmaison", username: "yannvid", first_name: "Yann", last_name: "Vidal" },
  { email: "emilie.giraud@gmail.com", password: "giraudpass", city: "Colombes", username: "emiligir", first_name: "Émilie", last_name: "Giraud" },
  { email: "arnaud.boyer@free.fr", password: "boyerpass", city: "Levallois-Perret", username: "arnoboy", first_name: "Arnaud", last_name: "Boyer" },
  { email: "sophie.poirier@laposte.net", password: "poirier123", city: "Aulnay-sous-Bois", username: "soppoi", first_name: "Sophie", last_name: "Poirier" },
  { email: "vincent.gautier@wanadoo.fr", password: "gautier456", city: "Champigny-sur-Marne", username: "vingaut", first_name: "Vincent", last_name: "Gautier" },
  { email: "clemence.perrin@gmail.com", password: "perrin789", city: "Antony", username: "clemperr", first_name: "Clémence", last_name: "Perrin" },
  { email: "etienne.collet@live.fr", password: "colletpass", city: "Ivry-sur-Seine", username: "etiencol", first_name: "Étienne", last_name: "Collet" },
  { email: "julien.legrand@gmail.com", password: "julien", city: "Paris", username: "julien", first_name: "Julien", last_name: "Legrand" }
]

users.each do |user|
  User.create(user)
end

puts '...'
puts 'Finished users ✅'

p '------'

puts "Création de Admin 👨🏻‍🎨"
admin = User.new(
  email: "admin@admin",
  password: "adminadmin",
  city: "Admin-city",
  username: "admin",
  first_name: "Admin",
  last_name: "Admin",
  )
admin.save!
puts '...'
puts 'Finish the Admin ✅'

puts "Création de Gautier 👨🏻‍🎨"
gautier = User.new(
  email: "gautier@gautier",
  password: "gautiergautier",
  city: "Gautier-city",
  username: "gautier",
  first_name: "Gautier",
  last_name: "DM",
  )
gautier.save!
puts '...'
puts 'Finish the Gautier ✅'

puts "Création de Gil 👨🏻‍🎨"
gil = User.new(
  email: "gil@gil",
  password: "gilgil",
  city: "Gil-city",
  username: "gil",
  first_name: "Gil",
  last_name: "G",
  )
gil.save!
puts '...'
puts 'Finish the Gil ✅'

puts "Création de Alison 👨🏻‍🎨"
alison = User.new(
  email: "alison@alison",
  password: "alisonalison",
  city: "Alison-city",
  username: "alison",
  first_name: "Alison",
  last_name: "G",
  )
alison.save!
puts '...'
puts 'Finish the Alison ✅'

puts "Création de Bruno 👨🏻‍🎨"
bruno = User.new(
  email: "bruno@bruno",
  password: "brunobruno",
  city: "Bruno-city",
  username: "bruno",
  first_name: "Bruno",
  last_name: "F",
  )
bruno.save!
puts '...'
puts 'Finish the Bruno ✅'

p '------'

puts 'Création de friendships 👨🏻‍🎨'
users = User.all

users.each do |user|
  target_friendships = rand(5..10)

  while user.friendships.count < target_friendships
    friend = users.sample
    next if user == friend || Friendship.exists?(user: user, friend: friend) || Friendship.exists?(user: friend, friend: user)

    Friendship.create!(user: user, friend: friend)
  end
  puts "Friendships for '#{user.first_name}' ✅"
end

puts '...'
puts 'Finished friendships ✅'

p '------'

puts 'Création de 5 collections pour chaque User 👨🏻‍🎨'

collections = [
  "Top Paris", "Gastro Chic", "Italien Lovers", "Street Food", "Vegan Vibes",
  "Fish & Seafood", "Pizza Mania", "Bistrot Style", "Healthy Eats", "Sweet Treats",
  "Brunch Spots", "Asian Delight", "Cozy Corners", "Date Night", "Burger Fix",
  "Rooftop Views", "Local Favorites", "Hidden Gems", "Night Bites", "Budget Bites"
]

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

users.each do |user|
  5.times do
    collection_name = collections.sample
    next if user.collections.exists?(name: collection_name)

    Collection.create!(
      name: collection_name,
      user: user,
      emoji: emojis.sample,
      color: colors.sample
    )
  end
end

puts 'Finished collections ✅'

p '------'

# puts 'Création de 5 saved_restos pour chaque User 👨🏻‍🎨'
# restaurants = Restaurant.all
# users.each do |user|
#   saved_restaurants = []
#   5.times do
#     restaurant = restaurants.sample
#     unless SavedRestaurant.exists?(user: user, restaurant: restaurant)
#       saved_restaurant = SavedRestaurant.create!(user: user, restaurant: restaurant)
#       saved_restaurants << saved_restaurant
#     end
#   end
#   user_collections = user.collections
#   saved_restaurants.each_with_index do |saved_restaurant, index|
#     collection = user_collections[index % user_collections.size]
#     SavedRestaurantsCollection.create!(collection: collection, saved_restaurant: saved_restaurant)
#   end
# end

# puts 'Finished saved_restos ✅'

puts 'Création de saved_restos pour chaque User 👨🏻‍🎨'

restaurants = Restaurant.all
users = User.all

users.each do |user|
  user_collections = user.collections

  user_collections.each do |collection|
    saved_restaurants = []
    rand(2..10).times do
      restaurant = restaurants.sample
      unless SavedRestaurant.exists?(user: user, restaurant: restaurant)
        saved_restaurant = SavedRestaurant.create!(user: user, restaurant: restaurant)
        saved_restaurants << saved_restaurant
      end
    end

    saved_restaurants.each do |saved_restaurant|
      SavedRestaurantsCollection.create!(collection: collection, saved_restaurant: saved_restaurant)
    end
  end
end

puts 'Finished saved_restos ✅'

p '------'

puts 'Création de 5 reviews pour chaque User 👨🏻‍🎨'

reviews = [
  "Great food and cozy atmosphere!",
  "Delicious dishes and friendly staff.",
  "A bit pricey, but totally worth it.",
  "Perfect spot for a casual dinner.",
  "Loved the ambiance and the drinks.",
  "Tasty meals with generous portions.",
  "Service was a bit slow, but the food made up for it.",
  "Amazing presentation and flavors.",
  "Great spot for a date night.",
  "One of my favorite places in the city.",
  "Quality ingredients and fresh flavors.",
  "Definitely coming back for more!",
  "Food was okay, but the vibe was great.",
  "Perfect for brunch with friends.",
  "Drinks were amazing, food was decent.",
  "Cosy place with lovely staff.",
  "Unique dishes and beautiful plating.",
  "Quick service and tasty food.",
  "Loved the dessert selection!",
  "Great for a quick bite!"
]

users = User.all
users.each do |user|
  5.times do
    saved_restaurant = user.saved_restaurants.sample
    Review.create!(
      content: reviews.sample,
      user_rating: rand(3..5),
      user: user,
      saved_restaurant: saved_restaurant
    )
  end
end

puts 'Finished creating reviews ✅'

p '------'

puts "Les restaurants commencent à l'ID #{Restaurant.first.id}"
puts "Les users commencent à l'ID #{User.first.id}"
puts "L'ID de l'admin est #{admin.id}"
puts "Les friendships commencent à l'ID #{Friendship.first.id}"
puts "Les collections commencent à l'ID #{Collection.first.id}"
puts "Les saved_restos commencent à l'ID #{SavedRestaurant.first.id}"
puts "Les saved_restos_collection commencent à l'ID #{SavedRestaurantsCollection.first.id}"
puts "Les reviews commencent à l'ID #{Review.first.id}"
