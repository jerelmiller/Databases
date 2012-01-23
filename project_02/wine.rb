require 'rubygems'
require 'sqlite3'

FILENAME = "wine.db"
SELECT_QUERY = "SELECT * FROM wine"
INSERT_STATEMENT = "INSERT into wine(name, price, purchase_date, drunk_date, rating, comment) VALUES(?, ?, ?, ?, ?, ?)"

puts "Listing all the wine in the database:" 
puts

db = SQLite3::Database.new(FILENAME)
db.results_as_hash = true

db.execute(SELECT_QUERY) do |row|
  puts row['name'];
  puts "Price: #{row['price']}"
  puts "Date Purchased: #{row['date_purchased']}"
  puts "Date Drunk: #{row['drunk_date']}"
  puts "Rating: #{row['rating']}"
  puts "Comment: #{row['comment']}"
  puts
end

puts "Enter the attributes of a new wine:"
puts
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

db.execute(INSERT_STATEMENT, [name, price, purchase_date, date_drunk, rating, comment])

db.close

puts "\nNew wine saved!"