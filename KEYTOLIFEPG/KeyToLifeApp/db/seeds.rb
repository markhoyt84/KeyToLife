# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


require 'csv'

csv_text = File.read('public/Distributor_Prices.csv')
csv = CSV.parse(csv_text, :headers => true)
csv.each do |row|
  Product.create!(row.to_hash)
end


categories = [{'name' => 'Key To Life Nutrients', 'description' => 'Unlock your way to a happier, healthier garden!'}, { 'name' => 'Easy Life Blends', 'description' => 'Make your life easier with our proven blends.'}, {'name' => 'Char O Lite', 'description' => 'Biochar plus All Purpose nutrients!'}, {'name' =>'Cyclone Brewers', 'description' => 'Brew your own FRESH nutrients at home!'}, {'name' =>'Induction Lights', 'description' => 'Low Energy, Low Heat, & High Yields!'}, { 'name' =>'Merchandise', 'description' => 'Key to life apparal and swag!'}]

categories.each do |nam|
  Category.create!(name: nam['name'], description: nam['description'])
end