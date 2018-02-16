require 'rubygems'
Bundler.setup
require 'awesome_print'

require 'csv'

require_relative './book.rb'
require_relative './books.rb'

# rubocop:disable Metrics/LineLength

def group_books
  Books.all
       .group_by { |book| book.number[/\D+/] }
end

def sort_demo
  grouped_books = group_books
  sorted_keys = grouped_books.keys.sort_by { |key| key || '' }
  books_strings = []
  sorted_keys.each do |key|
    books_strings << grouped_books[key]
                     .sort { |x, y| x.number[/\d+/].to_i == y.number[/\d+/].to_i ? x.title <=> y.title : x.number[/\d+/].to_i <=> y.number[/\d+/].to_i }
                     .map { |book| "Nummer: #{book.number}; Titel: #{book.title.encode('UTF-8')}" }
  end
  puts books_strings.flatten.join("\n")
  puts '-' * 79
end

sort_demo
puts(Books.all.map { |book| "Nummer: #{book.number}; Titel: #{book.title.encode('UTF-8')}" })

# rubocop:enable Metrics/LineLength