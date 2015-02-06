require 'spec_helper'

describe List do

  it 'is initialized with a name' do
    list = List.new('test name')
    expect(list).to be_a List
  end

  it 'tells you its name' do
    list = List.new('test name')
    expect(list.name).to eq 'test name'
  end

  it 'starts with no Lists' do
    expect(List.all).to eq []
  end

  it 'lets you save Lists to the database and tells you the list_id' do
    list = List.new('test name')
    list.save
    expect(List.all.first).to be_a List
    list = List.all.first
    expect(list.id).to be_a Integer
  end

end
