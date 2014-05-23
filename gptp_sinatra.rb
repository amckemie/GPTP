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
  erb :volunteer
end

get 'organization' do
  erb :organization
end

post '/volunteer-sign-in' do
  @result = GPTP::SignIn.new.run(params[:email], params[:password])
  if @result[:success?]
    session[:user] = @result[:volunteer]
    redirect '/volunteer'
  else
    session[:error] = @result[:error]
    redirect '/'
  end
end

post '/volunteer-sign-up' do
  @result = GPTP::VolunteerSignUp.new.run(params)
  if @result[:success?]
    session[:user] = @result[:volunteer]
    redirect 'volunteer'

  else
    session[:error] = @result[:error]
    redirect '/'
  end
end

post '/organization-sign-in' do
  @result = GPTP::SignIn.new.run(params[:email], params[:password])
  if @result[:success?]
    session[:user] = @result[:volunteer]
    redirect '/organization'
  else
    session[:error] = @result[:error]
    redirect '/'
  end
end

post '/organization-sign-up' do
  @result = GPTP::OrganizationSignUp.new.run(params)
  if @result[:success?]
    session[:user] = @result[:volunteer]
    redirect '/organization'
  else
    session[:error] = @result[:error]
    redirect '/'
  end
end
