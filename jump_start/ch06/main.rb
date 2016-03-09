# encoding: UTF-8

require 'rubygems'
require 'bundler/setup'

require 'coffee-script'
require 'sass'
require 'sinatra'
require './sinatra/auth'
require 'sinatra/flash'
require 'sinatra/reloader' if development?
require 'slim'
require './song.rb'
require 'v8'

configure :development do
  DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/development.db")
  set :username, 'fez'
  set :password, '1234'
end

configure :production do
  #production configuration here
end

configure :test do
  #test configuration here
end

helpers do
  def css(*stylesheets)
    stylesheets.map do |stylesheet|
      "<link href=\"/#{stylesheet}.css\" media=\"screen, projection\" rel=\"stylesheet\" />"
    end.join
  end
  
  def current?(path='/')
    (request.path == path || request.path == path+'/') ? "current" : nil
  end
  
  def set_title
    @title ||= "Songs By Sinatra"
  end
end

before do
  set_title
end

get('/styles.css'){ scss :styles }
get('/javascripts/application.js'){ coffee :application }

get '/' do
  slim :home
end

get '/about' do
  @title = 'All About This Website'
  slim :about
end

get '/contact' do
  slim :contact
end

not_found do
  slim :not_found
end