#!/usr/bin/env ruby

require 'rubygems'
require 'active_record'
require 'logger'

# "Hey Ruby, I've got a class called Test that extends the features provided
# by ActiveRecord. It doesn't use the AR naming convention, so be sure to
# rely on table 'test' for this classes database persistence."
class Test < ActiveRecord::Base
  
  def say_hello
    puts "\n\nHello, I'm #{name} and I think you should take the red pill.\n\n"
  end
  
end

# "Hey ActiveRecord, show me your activity log by printing it to the screen."
ActiveRecord::Base.logger = Logger.new(STDOUT)

# "Hey AR, connect to the database with the following options."
ActiveRecord::Base.establish_connection(
  :host => 'localhost',
  :username => 'root',
  :password => '',
  :adapter => 'mysql2',
  :database => 'zoolicious'
)

# "Hey AR, load the first record from the table 'test', and using those values
# instantiate a Test object for me."
t = Test.first

t.say_hello
