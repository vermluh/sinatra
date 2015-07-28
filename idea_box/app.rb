require './idea'

class IdeaBoxApp < Sinatra::Base
  not_found do
    erb :error
  end

  get '/' do
    erb :index
  end

  post '/' do
    idea = Idea.new
    "Creating an IDEA!"
  end
end
