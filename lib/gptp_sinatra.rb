require 'pry'
require 'sinatra'
require 'sinatra/reloader'
require_relative 'gptp.rb'

set :bind, '0.0.0.0'

enable :sessions
