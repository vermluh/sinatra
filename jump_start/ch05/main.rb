# encoding: UTF-8

require 'rubygems'
require 'bundler/setup'

require 'sass'
require 'sinatra'
require 'sinatra/flash'
require 'sinatra/reloader' if development?
require 'slim'
require './song.rb'

configure :development do
  enable :sessions
  set :username, 'frank'
  set :password, 'sinatra'
  DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/development.db")
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

get '/login' do
  slim :login
end

get '/logout' do
  session.clear
  redirect to('/login')
end

post '/login' do
  if params[:username] == settings.username && params[:password] == settings.password
    session[:admin] = true
    redirect to('/songs')
  else
    slim :login
  end
end

not_found do
  slim :not_found
end