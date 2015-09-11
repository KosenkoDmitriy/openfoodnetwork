# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

def destroy_countries
  begin
    puts "delete all countries"
    sql = "TRUNCATE spree_countries CASCADE;"
    items = ActiveRecord::Base.connection.execute(sql)
    puts items
  rescue
    "error destroy selected countries"
  end
end


# -- Spree
begin
  puts "[db:seed] Seeding Spree"
  Spree::Core::Engine.load_seed if defined?(Spree::Core)
  Spree::Auth::Engine.load_seed if defined?(Spree::Auth)
rescue
  "Seeding Spree::Core and Spree::Engine exception"
end

destroy_countries() #TODO: after add states to each country it should be removed

#TODO: import images
#TODO: create enteriprises (at least two) which have a SOUTH AFRICA adresses

# -- States and Suburbs
require_relative './suburb_seeds'
SuburbSeeder.seed_suburbs #unless Suburb.find_by_name("Dayton")
