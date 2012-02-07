require 'rubygems'
require 'sqlite3'

FILENAME = 'wine.db'

queries = [
 "CREATE TABLE countries(id INTEGER PRIMARY KEY, name TEXT);",
 "CREATE TABLE regions(id INTEGER PRIMARY KEY, name TEXT, country_id INTEGER);",
 "CREATE TABLE vinyards(id INTEGER PRIMARY KEY, name TEXT, parcel_id TEXT, region_id INTEGER, winery_id INTEGER);",
 "CREATE TABLE wineries(id INTEGER PRIMARY KEY, name TEXT, tax_id TEXT);",
 "CREATE TABLE wines(id INTEGER PRIMARY KEY, name TEXT, winery_id INTEGER, sku TEXT, vintage TEXT, price TEXT, purchase_date DATE, drunk_date DATE, rating INTEGER, comment TEXT)",
 "CREATE TABLE grapes(id INTEGER PRIMARY KEY, name TEXT);",
 "CREATE TABLE grapes_wines(grape_id INTEGER, wine_id INTEGER)",
 "CREATE TABLE grapes_vinyards(grape_id INTEGER, vinyard_id INTEGER);"
]

db = SQLite3::Database.new(FILENAME);
db.results_as_hash = true;

queries.each do |query|
  db.execute(query)
end

db.close


#db.get_first_value("SELECT last_insert_rowid();")

