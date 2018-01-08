# encoding: UTF-8

require 'rubygems'
Bundler.setup

require 'csv'
require 'json'
require 'sinatra'
require 'sinatra/json'
require 'slim'

require './book.rb'
require './books.rb'

Slim::Engine.options[:pretty] = true

get '/' do
  s = Books.all
        .sort do |x,y| 
          comp = (x.number.to_i <=> y.number.to_i)
          comp.zero? ? (x.title <=> y.title) : comp
        end
        .map { |book| "Nummer: #{book.number}; Titel: #{book.title.encode('UTF-8')}" }
        .join('<br/>')
  s
end

get '/all' do
  slim :main
end
=begin
get '/all.csv' do
  csv_string = CSV.generate({:col_sep => "\t"}) do |csv|
    KaFehlercode.order(:kaf_nummer).each do |row|
      csv << [row.kaf_nummer.to_i, row.kaf_text.encode('UTF-8')]
    end
  end
  
  content_type 'application/csv'
  attachment 'error_codes.csv'
  csv_string
end

get '/api/v1/error', :provides => :json do
  json KaFehlercode.order(:kaf_nummer).all
end

get '/api/v1/error/:number', :provides => :json do
  id = params[:number].to_i
  fehlercode = KaFehlercode[id]
  
  content_type :json
  json fehlercode
end
=end