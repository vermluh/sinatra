require 'rubygems'
require 'bundler/setup'

require 'sinatra/base'

require_relative 'main'
require_relative 'song'
require 'slim'

map('/songs') { run SongController }
map('/') { run Website }