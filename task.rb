require 'pg'


class Task
  attr_accessor :name, :id, :list_id

  def initialize( task )
    if task["id"] == nil
      @id = 0
      @name = task["description"]
      @list_id = task["list_id"].to_i
    else
      @id = task["id"].to_i
      if task["list_id"] == nil
        self.get_task_by_id
      else
        @list_id = task["list_id"].to_i
        @name = task["description"]
      end
    end
  end

  def self.all
    results = DB.exec("select * from tasks;")
    tasks = []
    results.each do |result|
      tasks << Task.new( result )
    end
    return tasks
  end

  def get_task_by_id
    result = DB.exec("select * from tasks where id = #{@id}")
    @name = result.first["description"]
    @list_id = result.first["list_id"].to_i
  end

  def update
    result = DB.exec("update tasks set description = '#{@name}', list_id = #{@list_id} where id = #{@id}")
  end

  def save
    result = DB.exec("insert into tasks ( description, list_id ) values ('#{@name}',#{@list_id}) RETURNING id;")
    @id = result.first["id"].to_i
    return @id
  end

  def ==(another_task)
    self.name == another_task.name && self.list_id == another_task.list_id
  end

end
