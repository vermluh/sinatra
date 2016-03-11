require 'rubygems'
require 'bundler/setup'

require 'sinatra/base'

require './main'
require './song'
require 'slim'

map('/songs') { run SongController }
map('/') { run Website }