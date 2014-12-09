require 'sinatra'

enable :sessions

get '/' do
  "Hello World!"
end

get '/about' do
  'A little about me.'
end

get '/hello/:name' do
  "Hello there, #{params[:name]}."
end

get '/form' do
  puts "Session var: #{session[:mark]}"
  erb :form
end

post '/form' do
  switch_state = params[:switch1].nil? ? 'off' : params[:switch1]
  session[:mark] = ((switch_state == 'off') ? 0 : 1)
  puts "Session var set to: #{session[:mark]}"
  puts "You said '#{params[:message]}' and the light switch was turned '#{switch_state}'"
  "You said '#{params[:message]}' and the light switch was turned '#{switch_state}'"
  redirect '/form'
end
