# encoding: UTF-8

require './applicationcontroller'
require 'coffee-script'
require 'sass'
require 'slim'
require 'v8'

class Website < ApplicationController
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
end