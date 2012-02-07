require 'rubygems'
require 'sqlite3'

FILENAME = 'wine.db'
db = SQLite3::Database.new(FILENAME)

drop_queries = [
  "DROP TABLE IF EXISTS countries",
  "DROP TABLE IF EXISTS regions",
  "DROP TABLE IF EXISTS vinyards",
  "DROP TABLE IF EXISTS wineries",
  "DROP TABLE IF EXISTS wines",
  "DROP TABLE IF EXISTS grapes",
  "DROP TABLE IF EXISTS grapes_wines",
  "DROP TABLE IF EXISTS grapes_vinyards"
]

drop_queries.each do |drop|
  db.execute(drop)
end
