# encoding: UTF-8

require 'rubygems'
require 'bundler/setup'

require 'sass'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'slim'

require './song.rb'

get('/styles.css'){ scss :styles }

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

get '/songs' do
  @songs = Song.all
  slim :songs
end

post '/songs' do
  song = Song.create(params[:song])
  redirect to("/songs/#{song.id}")
end

get '/songs/new' do
  @song = Song.new
  slim :new_song
end

get '/songs/:id' do
  @song = Song.get(params[:id])
  slim :show_song
end

put '/songs/:id' do
  song = Song.get(params[:id])
  song.update(params[:song])
  redirect to("/songs/#{song.id}")
end

delete '/songs/:id' do
  Song.get(params[:id]).destroy
  redirect to('/songs')
end

get '/songs/:id/edit' do
  @song = Song.get(params[:id])
  slim :edit_song
end

not_found do
  slim :not_found
end