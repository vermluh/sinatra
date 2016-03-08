require 'rubygems'
require 'bundler/setup'

require 'sass'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'slim'

get('/styles.css'){ scss :styles }

get '/' do
  slim :home
end

get '/about' do
  @title = "All About This Website"
  slim :about
end

get '/contact' do
  slim :contact
end

not_found do
  slim :not_found
end