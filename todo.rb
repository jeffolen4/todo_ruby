require 'sinatra'

require_relative './list'

set :public_folder, 'public'

DB = PG.connect( :dbname => "todo_test")

class Todo < Sinatra::Application
  set :layout, 'layout'

  @@lists = []
  @@tasks = []
  @@current_list = nil

  get '/' do
    @@lists = List.all
    if @@lists.count > 0
      @@current_list = @@lists.first
    end
    erb :index, :locals => { :lists => @@lists, :current_list => @@current_list }
  end

  get '/selectlist/:id' do
    @@current_list = List.new({ "id" => params['id'] })
    erb :index, :locals => { :lists => @@lists, :current_list => @@current_list }
  end

  post '/addlist' do
    new_list = List.new(params)
    if new_list.save
      @@lists = List.all
    end
    erb :index, :locals => { :lists => @@lists, :current_list => @@current_list }
  end

  post '/addtask' do
    new_task = Task.new(params)
    new_task.save
    erb :index, :locals => { :lists => @@lists, :current_list => @@current_list }
  end

    post '/updtask' do
      raise ArgumentError, { "params" => params }
      # new_task = Task.new(params)
      # new_task.save
      erb :index, :locals => { :lists => @@lists, :current_list => @@current_list }
    end

end
