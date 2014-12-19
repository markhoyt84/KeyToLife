# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


require 'csv'
csv_photos = File.read('public/product_data.csv')
photocsv = CSV.parse(csv_photos, :headers => true)
photocsv.each do |row|
  Photo.create!(row.to_hash)
end


csv_text = File.read('public/Distributor_Prices.csv')
csv = CSV.parse(csv_text, :headers => true)
csv.each do |row|
  Product.create!(row.to_hash)
end


categories = [{'name' => 'Key To Life Nutrients', 'description' => 'Unlock your way to a happier, healthier garden!'}, { 'name' => 'Easy Life Blends', 'description' => 'Make your life easier with our proven blends.'}, {'name' => 'Char O Lite', 'description' => 'Biochar plus All Purpose nutrients!'}, {'name' =>'Cyclone Brewers', 'description' => 'Brew your own FRESH nutrients at home!'}, {'name' =>'Induction Lights', 'description' => 'Low Energy, Low Heat, & High Yields!'}, { 'name' =>'Merchandise', 'description' => 'Key to life apparal and swag!'}]

photo_urls = ['http://i1278.photobucket.com/albums/y519/markhoyt84/Magic_Front_163_zpsc224fbbc.jpg', 'http://i1278.photobucket.com/albums/y519/markhoyt84/Bloom_Front_163_zpsfd05720f.jpg', 'http://i1278.photobucket.com/albums/y519/markhoyt84/Charolite_AP_Hcft2-625x750_zpscb54b98b.jpg', 'http://i1278.photobucket.com/albums/y519/markhoyt84/cyclone-brewer-650x650_zpscf5a9064.jpg', 'http://i1278.photobucket.com/albums/y519/markhoyt84/induction-light-coming-soon-1-650x650_zpse69d8d38.jpg', 'http://i1278.photobucket.com/albums/y519/markhoyt84/Hats-650x404_zps30c12875.jpg']
counter = 0
categories.each do |nam|
  new_cat = Category.create!(name: nam['name'], description: nam['description'])
  Photo.create!(url: photo_urls[counter], photoable_id: new_cat.id, photoable_type: 'Category')
  counter += 1
end

descriptions = File.open('public/product_partials_remade.csv', "r:ISO-8859-1")
desccsv = CSV.parse(descriptions, :headers => true)
desccsv.each do |row|
  p row
  Description.create!(row.to_hash)
end

