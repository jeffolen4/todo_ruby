require "pg"
require_relative "../list"
require_relative "../task"

DB = PG.connect( :dbname => "todo_development")

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("delete from lists;")
  end
end
