require 'spec_helper'


describe List do

  it 'is initialized with a name' do
    list = List.new({ "name" => 'test name'})
    expect(list).to be_a List
  end

  it 'tells you its name' do
    list = List.new({ "name" => 'test name'})
    expect(list.name).to eq 'test name'
  end

  it 'starts with no Lists' do
    expect(List.all).to eq []
  end

  it 'lets you save Lists to the database and tells you the list_id' do
    list = List.new({ "name" => 'test name'})
    list.save
    expect(List.all.first).to be_a List
    new_list = List.all.first
    expect(new_list.id).to be_a Integer
  end

  it "lets you retrieve the tasks by list id" do
    list = List.new({ "name" => 'test name'})
    list.save
    lists = List.all
    list = lists[-1]
    task1 = Task.new({ "description" => "test task name", "list_id" => list.id })
    task1.save
    tasks = list.get_tasks_by_id
    expect(tasks[0]).to be_a Task
    expect(tasks[0].list_id).to eq(list.id)
  end

  it "lets you retrieve a list by id" do
    list = List.new({ "name" => 'test name'})
    list.save
    list2 = List.new({ "id" => list.id })
    expect(list2).to eq(list)
  end

end
