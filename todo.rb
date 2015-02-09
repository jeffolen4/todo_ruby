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
    delete_ids = params["del_ids"]
    done_ids = params["done_ids"]
    undone_ids = params["undone_ids"]
    if delete_ids != nil && delete_ids.count > 0
      delete_ids.each do |del_id|
        del_task = Task.new( {"id" => del_id.to_i, "list_id" => @@current_list.id })
        del_task.delete
      end
    end
    if done_ids != nil && done_ids.count > 0
      done_ids.each do |done_id|
        done_task = Task.new( {"id" => done_id.to_i, "list_id" => @@current_list.id })
        done_task.complete( true )
      end
    end
    if undone_ids != nil && undone_ids.count > 0
      undone_ids.each do |undone_id|
        undone_task = Task.new( {"id" => undone_id.to_i, "list_id" => @@current_list.id })
        undone_task.complete( false )
      end
    end
  end

end
