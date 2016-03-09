# encoding: UTF-8

require 'dm-core'
require 'dm-migrations'

DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/development.db")

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