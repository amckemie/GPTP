require 'pry'
require 'sinatra'
require 'sinatra/reloader'
require "sinatra/content_for"
require_relative './lib/gptp.rb'

set :bind, '0.0.0.0'

enable :sessions

get '/' do
  erb :home
end

get '/volunteer' do
  @name = params[:name]
  erb :volunteer
end

get '/organization' do
  erb :organization
end
