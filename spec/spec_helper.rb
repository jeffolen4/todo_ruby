require "pg"
require "list"
require "task"

DB = PG.connect( :dbname => "todo_test")

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("delete from lists;")
  end
end
