require 'pry'
require 'sinatra'
require 'sinatra/reloader'
require_relative './lib/gptp.rb'

set :bind, '0.0.0.0'

enable :sessions

get '/' do
  erb :home
end

post '/volunteer' do
  @name = params[:name]
  erb :volunteer, :layout => :users
end

post '/organization' do
  erb :organization, :layout => :users
end
