require 'rubygems'
require 'bundler'
require 'sinatra'
require 'pg'

Bundler.require

# set :views, File.dirname(__FILE__) + "/views"
set :root, './'

require './todo'
run Todo
