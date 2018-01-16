# encoding: UTF-8

require 'rubygems'
Bundler.setup
require 'awesome_print'

require 'csv'

require_relative './book.rb'
require_relative './books.rb'

def get_demo()
  Books.all.sort { |x,y| x.number.to_i <=> y.number.to_i }.each do |book|
    s = "Nummer: #{book.number}; Titel: #{book.title.encode('UTF-8')}"
    ap s
  end
end

get_demo()
