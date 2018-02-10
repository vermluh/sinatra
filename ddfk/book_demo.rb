# encoding: UTF-8

require 'rubygems'
Bundler.setup
require 'awesome_print'

require 'csv'

require_relative './book.rb'
require_relative './books.rb'

def sort_demo()
  grouped = Books.all
                 .group_by { |book| book.number[/\D+/] }
  sorted_keys = grouped.keys.sort_by {|key| key ||= ''}
  books_strings = []
  sorted_keys.each do |key|
    books_strings << grouped[key]
                       .sort do |x,y| 
                         comp = (x.number.to_i <=> y.number.to_i)
                         comp.zero? ? (x.title <=> y.title) : comp
                       end
                       .map { |book| "Nummer: #{book.number}; Titel: #{book.title.encode('UTF-8')}" }
  end
  puts books_strings.flatten.join("\n")
  puts "-" * 79
end

sort_demo()
puts Books.all.map { |book| "Nummer: #{book.number}; Titel: #{book.title.encode('UTF-8')}" }