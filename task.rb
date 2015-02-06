require 'pg'

class Task
  attr_accessor :name
  attr_accessor :list_id

  def initialize( name, list_id)
    @name = name
    @list_id = list_id
  end

  def self.all
    results = DB.exec("select * from tasks;")
    tasks = []
    results.each do |result|
      name = result['description']
      list_id = result['list_id']
      tasks << Task.new(name, list_id)
    end
    return tasks
  end

  def name= name
    @name = name
  end

    def list_id= list_id
      @list_id = list_id
    end

  def save
    DB.exec("insert into tasks ( description, list_id ) values ('#{@name}',#{@list_id});")
  end

  def ==(another_task)
    self.name == another_task.name && self.list_id == another_task.list_id
  end

end
