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

post '/volunteer' do
  @result = GPTP::SignIn(params[:email], params[:password])
  if @result[:success?]
    session[:user] = @result[:volunteer]
    erb :volunteer
  else
    session[:error] = @result[:error]
    redirect '/'
  end
  erb :volunteer
end

post '/organization' do
  @result = GPTP::SignIn(params[:email], params[:password])
  if @result[:success?]
    session[:user] = @result[:volunteer]
    erb :volunteer
  else
    session[:error] = @result[:error]
    redirect '/'
  end
  erb :organization
end
