# encoding: UTF-8

require 'rubygems'
require 'bundler/setup'

require 'awesome_print'
require 'csv'
require 'json'
require 'sinatra'
require 'sinatra/json'
require 'slim'
require 'sequel'
require 'sqlite3'

require_relative 'kafehlercode'

Slim::Engine.options[:pretty] = true

get '/' do
  s = "viele Fehlercodesäöüß"
  puts s.encoding
  puts s
  f990 = KaFehlercode[990]
  s = "Nummer: #{f990[:kaf_nummer].to_i}; Text #{f990[:kaf_text].encode('UTF-8')}"
  s
end

get '/all' do
  slim :main
end

get '/all.csv' do
  content_type 'application/csv'
  attachment 'error_codes.csv'
  
  csv_string = CSV.generate({:col_sep => "\t"}) do |csv|
    KaFehlercode.order(:kaf_nummer).each do |row|
      csv << [row.kaf_nummer.to_i, row.kaf_text.encode('UTF-8')]
    end
  end
  
  csv_string
end

get '/api/v1/error/:number', :provides => :json do
  id = params[:number].to_i
  fehlercode = KaFehlercode[id]
  
  content_type :json
  json fehlercode
end
