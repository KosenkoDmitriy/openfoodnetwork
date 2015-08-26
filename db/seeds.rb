# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

# -- Spree
unless Spree::Country.find_by_name 'Australia'
  puts "[db:seed] Seeding Spree"
  Spree::Core::Engine.load_seed if defined?(Spree::Core)
  Spree::Auth::Engine.load_seed if defined?(Spree::Auth)
end

# -- States
unless Spree::State.find_by_name 'Victoria'
  country = Spree::Country.find_by_name('Australia')
  puts "[db:seed] Seeding states of the Australia"

  [
      ['ACT', 'ACT'],
      ['New South Wales', 'NSW'],
      ['Northern Territory', 'NT'],
      ['Queensland', 'QLD'],
      ['South Australia', 'SA'],
      ['Tasmania', 'Tas'],
      ['Victoria', 'Vic'],
      ['Western Australia', 'WA']
  ].each do |state|
    Spree::State.create!({"name" => state[0], "abbr" => state[1], :country => country}, :without_protection => true)
  end
end

unless Spree::State.find_by_abbr 'ZA-NW'
  country = Spree::Country.find_by_iso('ZA')
  puts "[db:seed] Seeding state of the South Africa"
  [
      ['Eastern Cape', 'ZA-EC'],
      ['Free State', 'ZA-FS'],
      ['Gauteng', 'ZA-GT'],
      ['KwaZulu-Natal', 'ZA-NL'],
      ['Limpopo', 'ZA-LP'],
      ['Mpumalanga', 'ZA-MP'],
      ['Northern Cape', 'ZA-NC'],
      ['North West', 'ZA-NW'],
      ['Western Cape', 'ZA-WC']
  ].each do |state|
    Spree::State.create!({name: state[0], abbr: state[1], country: country}, without_protection: true)
  end
end

# -- Suburbs
require_relative './suburb_seeds'
SuburbSeeder.seed_suburbs unless Suburb.find_by_name("Dayton")
