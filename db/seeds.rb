# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

def destroy_countries
  begin
    puts "delete all countries"
    sql = "TRUNCATE spree_countries CASCADE;"
    # sql = "TRUNCATE spree_countries;"
    items = ActiveRecord::Base.connection.execute(sql)
    puts items

    # # Spree::Country.where(iso3:["ZA","AU"]).destroy_all
    #   country_ids = Spree::Country.where(iso3: ["ZA", "AU"]).pluck(:id)
    #   puts "delete all countries except: #{country_ids}"
    #   if (country_ids.empty?)
    #     items = Spree::Country.destroy_all
    #   else
    #     items = Spree::Country.where('id not in (?)', country_ids).destroy_all
    #   end
  rescue
    "error destroy selected countries"
  end
end

# -- Spree
begin
  unless Spree::Country.find_by_iso('ZA')
    puts "[db:seed] Seeding Spree"
    Spree::Core::Engine.load_seed if defined?(Spree::Core)
    Spree::Auth::Engine.load_seed if defined?(Spree::Auth)
  end
rescue
  "Seeding Spree::Core and Spree::Engine exception"
end

destroy_countries() #TODO: after add states to each country it should be removed

#TODO: import images
#TODO: create enteriprises (at least two) which have a SOUTH AFRICA adresses

# -- States and Suburbs
require_relative './suburb_seeds'
SuburbSeeder.seed_suburbs #unless Suburb.find_by_name("Dayton")

email="spree@example.com"
password="spree123"
u=Spree::User.where(email:email).first_or_create!(email:email,password:password)
