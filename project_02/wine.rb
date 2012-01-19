require 'sqlite3'

db = SQLite3::Database.new( "wine.db" )
#db.execute("select * from wine") do |row|
#  puts row
#end