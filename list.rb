require 'pg'
require_relative 'task'

# DB = PG.connect(:dbname => "todo_test")

class List
  attr_accessor :name, :tasks, :id

  def initialize( list  )
    if list["id"] == nil
      @id = 0
      @name = list["name"]
    else
      @id = list["id"].to_i
      if list["name"] == nil
        self.get_list_by_id
      else
        @name = list["name"]
      end
    end
  end

  def self.all
    results = DB.exec("select * from lists;")
    lists = []
    results.each do |result|
      lists << List.new( result )
    end
    return lists
  end

  def get_list_by_id
    result = DB.exec("select * from lists where id = #{@id}")
    self.name = result.first["name"]
  end

  def get_tasks_by_id
    @tasks = []
    results = DB.exec("select * from tasks where list_id = #{@id}")
    results.each do |result|
      @tasks << Task.new(result)
    end
    return @tasks
  end

  def update
    return DB.exec("update lists set name = #{@name} where id = #{@id}")
  end

  def save
    result = DB.exec("insert into lists ( name ) values ('#{@name}') RETURNING id;")
    @id = result.first["id"].to_i
    return @id
  end

  def ==(another_list)
    if ( another_list != nil )
      return self.name == another_list.name
    else
      return false
    end
  end

end
