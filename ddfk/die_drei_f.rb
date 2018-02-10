# encoding: UTF-8

require 'rubygems'
Bundler.setup

require 'csv'
require 'json'
require 'sinatra'
require 'sinatra/json'
require 'slim'

require_relative 'book'
require_relative 'books'

Slim::Engine.options[:pretty] = true

class DDFK < Sinatra::Base
  get '/' do
    s = Books.all
          .map { |book| "Nummer: #{book.number}; Titel: #{book.title.encode('UTF-8')}" }
          .join('<br/>')
    s
  end

  get '/all' do
    slim :main
  end
end
