require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'sinatra/reloader' if development?

get '/frank' do
  name = "Frank"
  "Hello #{name}"
end

get '/hello' do
  "Hello Sinatra!"
end

get '/:name' do
  name = params[:name]
  "Hi there #{name}!"
end
