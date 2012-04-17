#!/usr/bin/env ruby

require 'rubygems'
require 'active_record'
require 'logger'

# Class user to use for 'users' table
class User < ActiveRecord::Base

  # Return the count of the number of users
  def self.list_users_count
    puts "Listing #{User.count} users in the database sorted by last name"
  end

  # Retrun all of the users sorted by last name
  def self.list_users
    self.order('last_name').all.each do |user|
      puts user.to_s
    end
  end

  # Override the to_s output for the user
  def to_s
    "#{self.first_name} #{self.last_name} (#{self.username})"
  end
end

# Print the logging to the screen
ActiveRecord::Base.logger = Logger.new(STDOUT)

# Connect to the database with the following options
ActiveRecord::Base.establish_connection(
  :host => 'localhost',
  :username => 'root',
  :password => '',
  :adapter => 'mysql2',
  :database => 'zoolicious'
)

# Output stats to the console using the User methods 
puts "ZOOOOOLICIOUS!!!"

User.list_users_count
User.list_users
