require 'spec_helper'

list_id = 0

describe Task do

  it 'is initialized with a name and a list id' do
    list = List.new({"name" => "test list"})
    list.save
    task = Task.new({"description" => 'test name', "list_id" => list.id })
    expect(task).to be_a Task
  end

  it 'tells you its name' do
    list = List.new({"name" => "test list"})
    list.save
    task = Task.new({"description" => 'test name', "list_id" => list.id })
    expect(task.name).to eq 'test name'
  end

  it 'tells you its list id' do
    list = List.new({"name" => "test list"})
    list.save
    task = Task.new({"description" => 'test name', "list_id" => list.id })
    expect(task.list_id).to eq list.id
  end

  it 'starts with no tasks' do
    expect(Task.all).to eq []
  end

  it 'lets you save tasks to the database' do
    list = List.new({"name" => "test list"})
    list.save
    task = Task.new({"description" => 'test name', "list_id" => list.id })
    task.save
    expect(Task.all.first).to be_a Task
  end

  it 'lets you update the task name' do
    list = List.new({"name" => "test list"})
    list.save
    task = Task.new({"description" => 'test name', "list_id" => list.id })
    task.save
    task.name = "updated task name"
    task.update
    task2 = Task.new({"id" => task.id })
    expect(task2).to eq(task)
  end

end
