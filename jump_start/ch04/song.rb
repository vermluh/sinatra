# encoding: UTF-8

require 'dm-core'
require 'dm-migrations'

configure :development do
  DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/development.db")
end

configure :production do
  #production configuration here
end

configure :test do
  #test configuration here
end

class Song
  include DataMapper::Resource
  property :id, Serial
  property :title, String
  property :lyrics, Text
  property :length, Integer
  property :released_on, Date
  
  def released_on=date
    super Date.strptime(date, '%Y-%m-%d')
  end
end

DataMapper.finalize