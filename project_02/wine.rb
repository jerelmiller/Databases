require 'rubygems'
require 'sqlite3'
require 'yaml'

puts "Listing all the wine in the database:\n\n" 

db = SQLite3::Database.new("wine.db")

db.execute("SELECT * FROM wine") do |row|
  puts row[1]
  puts "Price: #{row[2]}"
  puts "Date Purchased: #{row[3]}"
  puts "Date Drunk: #{row[4]}"
  puts "Rating: #{row[5]}"
  puts "Comment: #{row[6]}"
  puts "\n"
end

puts "Enter the attributes of a new wine:\n"
print "Name: "
name = gets.chomp

print "Price: "
price = gets.chomp

print "Purchase Date: "
purchase_date = gets.chomp

print "Date Drunk: "
date_drunk = gets.chomp

print "Rating: "
rating = gets.chomp

print "Comment: "
comment = gets.chomp

sql = "INSERT into wine(name, price, purchase_date, drunk_date, rating, comment) VALUES('#{name}', '#{price}', '#{purchase_date}', '#{date_drunk}', '#{rating}', '#{comment}')"
db.execute(sql)

puts "\nNew wine saved!"