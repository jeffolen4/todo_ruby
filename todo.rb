require 'sinatra'

require_relative './list'

set :public_folder, 'public'

DB = PG.connect( :dbname => "todo_test")

class Todo < Sinatra::Application
  set :layout, 'layout'

  get '/' do
    current_list = nil
    if List.all.count > 0
      current_list = List.all.first
    end
    erb(:index)
  end

  get '/selectlist/:id' do
    raise params.inspect
  end

  post '/addlist' do
    new_list = List.new(params)
    if new_list.save
      if List.all.count > 0
        current_list = List.all.first
      end
    end
    erb(:index)
  end



  # get '/merch' do
  #   erb(:merch)
  # end
  #
  # get '/madlib-form' do
  #   erb(:form)
  # end
  #
  # get '/madlib-story' do
  #   @person1 = params.fetch('person1', "{no person1}")
  #   @person2 = params.fetch('person2', "{no person2}")
  #   @animal = params.fetch('animal', "{no animal}")
  #   @exclamation = params.fetch('exclamation', "{no explamation}")
  #   @verb = params.fetch('verb', "{no verb}")
  #   @noun = params.fetch('noun', "{no noun}")
  #   erb(:story)
  # end

end
