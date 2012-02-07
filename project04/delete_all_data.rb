require 'rubygems'
require 'sqlite3'

FILENAME = 'wine.db'

db = SQLite3::Database.new(FILENAME)

clear_queries = [
  "DELETE FROM countries",
  "DELETE FROM regions",
  "DELETE FROM grapes",
  "DELETE FROM grapes_vinyards",
  "DELETE FROM grapes_wines",
  "DELETE FROM vinyards",
  "DELETE FROM wineries",
  "DELETE FROM wines"
]

clear_queries.each do |delete|
  db.execute(delete)  
end

db.close