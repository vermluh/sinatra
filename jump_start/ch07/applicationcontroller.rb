# encoding: UTF-8

#require 'rubygems'
#require 'bundler/setup'

require 'sinatra/base'
require './sinatra/auth'
require 'sinatra/flash'

class ApplicationController < Sinatra::Base
  register Sinatra::Flash
  register Sinatra::Auth
  
  configure do
    enable :sessions
    set :username, 'fez'
    set :password, '1234'
  end
  
  before do
    set_title
  end

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