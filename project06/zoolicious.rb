#!/usr/bin/env ruby

require 'rubygems'
require 'active_record'
require 'logger'

#
# Configuration
# 
#ActiveRecord::Base.logger = Logger.new(STDOUT)
ActiveRecord::Base.establish_connection(
  :host => 'localhost',
  :username => 'root',
  :password => '',
  :adapter => 'mysql2',
  :database => 'zoolicious'
)

#
# Class definitions
#
class Animal < ActiveRecord::Base

  has_and_belongs_to_many :feeds
  has_and_belongs_to_many :users
  belongs_to :habitat

  validate :cuteness_must_be_within_range

  def cuteness_must_be_within_range
    errors.add(:cuteness, "can't be above 100") if cuteness > 100
    errors.add(:cuteness, "can't be below 1") if cuteness < 1
  end

  def to_s
    name
  end
  
end

class Feed < ActiveRecord::Base

  has_and_belongs_to_many :animals

  def to_s
    name
  end

end

class Habitat < ActiveRecord::Base

  has_many :animals
  belongs_to :zoo

  def to_s
    name
  end

end

class User < ActiveRecord::Base

  has_and_belongs_to_many :animals

  def to_s
    "#{first_name} #{last_name} (#{username})"
  end

end

class Zoo < ActiveRecord::Base

  has_many :habitats

  def to_s
    name
  end

end


#
# Core functions.
#
def main_menu
  puts "Main Menu."
  puts "A. List Zoos"
  puts "B. List Feeds"
  puts "C. List Habitats"
  puts "D. List Animals"
  puts "E. List Users"
  puts "F. Add a New Animal"
  puts "Q. Quit"
end

# Displays habitat ids, prompts the user to select one.
def capture_habitat
  habitats = Habitat.all
  command = nil
  while (!(habitats.collect { |h| h.id }.include? command.to_i))
    habitats.each do |habitat|
      puts "#{habitat.id} #{habitat.name}"
    end
    puts "Habitat: "
    command = gets.chomp!
  end
  return habitats.select { |h| h.id == command.to_i}.first
end

# Prompts the user for all animal attributes.
# Returns a name, description, cuteness score and a Habitat.
def capture_animal_attributes
  puts "Animal name: "
  name = gets.chomp!
  puts "Description: "
  description = gets.chomp!
  puts "Cuteness: "
  cuteness = gets.chomp!
  habitat = capture_habitat
  return name, description, cuteness.to_i, habitat
end

# Displays all the zoos and their habitats.
def list_zoos
  Zoo.all.each do |zoo|
    puts zoo
    puts zoo.habitats
  end
end

# Displays all the feeds and the animals that eat each feed.
def list_feeds
  Feed.all.each do |feed|
    puts
    puts feed
    puts "Listing animals that eat #{feed}:"
    puts feed.animals
  end
end

# Displays all the habitats, the zoo that owns each habitat,
# and the animals that occupy each habitat.
def list_habitats
  Habitat.all.each do |habitat|
    puts
    puts habitat
    puts "Listing zoo that owns #{habitat}:"
    puts habitat.zoo
    puts "Listing animals that occupy #{habitat}:"
    puts habitat.animals
  end
end

# Displays all the animals, the people that favor each animal,
# and the habitat in which each lives.
def list_animals
  Animal.all.each do |animal|
    puts
    puts animal
    puts "Listing habitat that #{animal} occupies:"
    puts animal.habitat
    puts "Listing users that favor #{animal}:"
    puts animal.users
  end
end

# Displays all the users and their favorite animals.
def list_users
  User.all.each do |user|
    puts
    puts user
    puts "Listing favorite animals for #{user}: "
    puts user.animals
  end
end

# Captures attributes from the program user and saves a new
# animal in the database.
def create_animal
  name, description, cuteness, habitat = capture_animal_attributes
  animal = Animal.new(:name => name, :description => description, :cuteness => cuteness, :habitat => habitat)
  
  unless animal.valid? 
    puts "Error! Animal not saved."
    animal.errors.each do |error, msg|
      puts "#{error.capitalize} #{msg}"
    end
  else
    animal.save!
  end

end

def execute_command(command)
  case command
  when "A"
    puts "Listing Zoos"
    list_zoos
  when "B"
    puts "Listing Feeds"
    list_feeds
  when "C"
    puts "Listing Habitats"
    list_habitats
  when "D"
    puts "Listing Animals"
    list_animals
  when "E"
    puts "Listing Users"
    list_users
  when "F"
    puts "Adding a new Animal"
    create_animal
  when "Q"
    puts "Quitting... buh-bye."
  else
    puts "Sorry, I don't know how to do that. Too bad so sad."
  end
end

command = nil
puts "Zoolicious application simulator. Whee!"
while (command != 'Q')
  main_menu
  execute_command(command = gets.chomp! )
end