require 'spec_helper'

list_id = 0
puts "listid: #{list_id}"

describe Task do

  it 'is initialized with a name and a list id' do
    task = Task.new('test name', list_id)
    expect(task).to be_a Task
  end

  it 'tells you its name' do
    task = Task.new('test name', list_id)
    expect(task.name).to eq 'test name'
  end

  it 'tells you its list id' do
    task = Task.new('test name', list_id)
    expect(task.list_id).to eq list_id
  end

  it 'starts with no tasks' do
    expect(Task.all).to eq []
  end

  it 'lets you save tasks to the database' do
    DB.exec("insert into lists ( name ) values ('test list 1') returning id;")
    list_id = List.all.first.id
    task = Task.new('test name', list_id)
    task.save
    expect(Task.all.first).to be_a Task
  end

end
