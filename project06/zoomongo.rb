#! /usr/bin/env ruby
require 'mongo_mapper'

MongoMapper.connection = Mongo::Connection.new('staff.mongohq.com', 10033) 
MongoMapper.database = "zoolicious" 
MongoMapper.database.authenticate('csci403', 'csci403')

class Animal
  include MongoMapper::Document

  key :name, String, :required => true
  key :description, String
  key :cuteness, Integer

  def to_s
    "#{name}, #{description}, (cuteness: #{cuteness})"
  end
end

puts "Displaying all the Animals in the database..."

Animal.all.each do |animal|
  puts animal
end
