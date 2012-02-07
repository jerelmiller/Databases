require 'rubygems'
require 'sqlite3'

FILENAME = 'wine.db'
SELECT_COUNTRIES = "SELECT distinct(country_name) FROM wines_tmp"
INSERT_COUNTRY = "INSERT INTO countries(name) VALUES(?)"

SELECT_REGIONS = "SELECT distinct(region_name), country_name FROM wines_tmp WHERE region_name NOT NULL"
INSERT_REGION = "INSERT INTO regions(name, country_id) VALUES(?, ?)"

SELECT_WINERIES = "SELECT distinct(winery_name) FROM wines_tmp"
INSERT_WINERY = "INSERT INTO wineries(name) VALUES(?)"

SELECT_VINYARDS = "SELECT distinct(vinyard_name), region_name, winery_name FROM wines_tmp WHERE vinyard_name NOT NULL"
INSERT_VINYARDS = "INSERT INTO vinyards(name, region_id, winery_id) VALUES(?, ?, ?)"

SELECT_GRAPES = "SELECT distinct(grape_name) FROM wines_tmp"
INSERT_GRAPES = "INSERT INTO grapes(name) VALUES(?)"

SELECT_WINES = "SELECT name, winery_name, vintage, price, purchase_date, drunk_date, rating, comment FROM wines_tmp"
INSERT_WINES = "INSERT INTO wines(name, winery_id, vintage, price, purchase_date, drunk_date, rating, comment) VALUES(?, ?, ?, ?, ?, ?, ?, ?)"

SELECT_GRAPES_VINYARDS = "SELECT grape_name, vinyard_name FROM wines_tmp WHERE vinyard_name NOT NULL"
INSERT_GRAPES_VINYARDS = "INSERT INTO grapes_vinyards(grape_id, vinyard_id) VALUES (?, ?)"

SELECT_GRAPES_WINES = "SELECT grape_name, name FROM wines_tmp"
INSERT_GRAPES_WINES = "INSERT INTO grapes_wines(grape_id, wine_id) VALUES(?, ?)"

db = SQLite3::Database.new(FILENAME)
db.results_as_hash = true

# Insert Countries into countries table
db.execute(SELECT_COUNTRIES) do |country|
  db.execute(INSERT_COUNTRY, [country['country_name']])
end

# Insert regions and country ids into regions table
db.execute(SELECT_REGIONS) do |region|
  country_id = db.get_first_value("SELECT id FROM countries WHERE name = '#{region['country_name']}'")
  db.execute(INSERT_REGION, [region['region_name'], country_id])
end

# Insert wineries into wineries table
db.execute(SELECT_WINERIES) do |winery|
  db.execute(INSERT_WINERY, [winery['winery_name']])
end

# Insert vinyards into vinyards table
db.execute(SELECT_VINYARDS) do |vinyard|
  region_id = db.get_first_value("SELECT id FROM regions WHERE name = '#{vinyard['region_name']}'")
  winery_id = db.get_first_value("SELECT id FROM wineries WHERE name = '#{vinyard['winery_name']}'")
  
  db.execute(INSERT_VINYARDS, [vinyard['vinyard_name'], region_id, winery_id])
end

# Insert grapes into grapes table
db.execute(SELECT_GRAPES) do |grape|
  grape['grape_name'].split(', ').each do |grape_name|
    db.execute(INSERT_GRAPES, grape_name)
  end
end

#insert wines into wines table
db.execute(SELECT_WINES) do |wine|
  winery_id = db.get_first_value("SELECT id FROM wineries WHERE name = '#{wine['winery_name']}'")
  db.execute(INSERT_WINES, [wine['name'], winery_id, wine['vintage'], wine['price'], wine['purchase_date'], wine['drunk_date'], wine['rating'], wine['comment']])
end

# Insert grapes and vinyards into the grapes_vinyards table
db.execute(SELECT_GRAPES_VINYARDS) do |grape_vinyard|
  
  grape_vinyard['grape_name'].split(', ').each do |grape_name|
    grape_id = db.get_first_value("SELECT id FROM grapes WHERE name = '#{grape_name}'")
    vinyard_id = db.get_first_value("SELECT id FROM vinyards WHERE name = '#{grape_vinyard['vinyard_name']}'")

    db.execute(INSERT_GRAPES_VINYARDS, [grape_id, vinyard_id])
  end

end

# Insert grapes and wines into grapes_wines table
db.execute(SELECT_GRAPES_WINES) do |grape_wine|

  grape_wine['grape_name'].split(', ').each do |grape_name|
    grape_id = db.get_first_value("SELECT id FROM grapes WHERE name = '#{grape_name}'")
    wine_id = db.get_first_value("SELECT id FROM wines WHERE name = '#{grape_wine['name']}'")

    db.execute(INSERT_GRAPES_WINES, [grape_id, wine_id])
  end
  
end


db.close