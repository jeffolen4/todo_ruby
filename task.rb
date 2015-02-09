require 'pg'


class Task
  attr_accessor :name, :id, :list_id, :done, :due_date

  def initialize( task )
    if task["id"] == nil
      @id = 0
      @name = task["description"]
      @list_id = task["list_id"].to_i
      @done = false
      @due_date = nil
    else
      @id = task["id"].to_i
      if task["list_id"] == nil
        self.get_task_by_id
      else
        @list_id = task["list_id"].to_i
        @name = task["description"]
        @done = task["done"]
        @due_date = task["due_date"]
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
    @id = result.first["id"].to_i
    @done = result.first["done"]
    @due_date = result.first["due_date"]
  end

  def complete ( is_complete )
    result = DB.exec("update tasks set done = #{is_complete} where id = #{@id}")
  end

  def delete
    result = DB.exec("delete from tasks where id = #{@id}")
  end

  def update
    result = DB.exec("update tasks set description = '#{@name}', list_id = #{@list_id} where id = #{@id}")
  end

  def save
    sql_string = "insert into tasks ( description, list_id, done";
    sql_string += @due_date == nil ? ") values ('#{@name}',#{@list_id}, #{@done} )" : ", due_date) values ('#{@name}',#{@list_id}, #{@done}, '#{@due_date}' )"
    sql_string += " RETURNING id;"
    result = DB.exec(sql_string)
    @id = result.first["id"].to_i
    return @id
  end

  def ==(another_task)
    self.name == another_task.name && self.list_id == another_task.list_id
  end

end
