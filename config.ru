require 'rubygems'
require 'bundler'
require 'sinatra'
require 'pg'

Bundler.require

# set :views, File.dirname(__FILE__) + "/views"
set :root, './lib'

require './todo'
run Todo
