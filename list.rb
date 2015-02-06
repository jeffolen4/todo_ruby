require 'pg'
require_relative 'task'

DB = PG.connect(:dbname => "todo_test")

class List
  attr_accessor :name
  attr_accessor :id

  def initialize( name, id = nil )
    @name = name
    @id = id
  end

  def self.all
    results = DB.exec("select * from lists;")
    lists = []
    results.each do |result|
      name = result['name']
      id = result['id'].to_i
      lists << List.new(name, id )
    end
    return lists
  end

  def name= name
    @name = name
  end

    def id= id
      @id = id
    end

  def save
    @id = DB.exec("insert into lists ( name ) values ('#{@name}') RETURNING id;")
  end

  def ==(another_list)
    self.name == another_list.name
  end

end
