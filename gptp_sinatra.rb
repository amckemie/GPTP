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
  # if session[:user] == nil
  #   erb :error
  # else
    email = session[:user].email
    @pennies = GPTP::GetPennies.new.run(vol: email)
    erb :volunteer, :layout => :users
  # end
end

get '/organization' do
  if session[:user] == nil
    erb :error
  else
    email = session[:user].email
    @pennies = GPTP::GetPennies.new.run(org: email)
    erb :organization, :layout => :users
  end
end

get '/all-volunteers' do
  # @volunteers = GPTP::
end

get '/all-organizations' do
end

post '/volunteer-sign-in' do
  @result = GPTP::SignIn.new.run(params[:email], params[:password], true)
  if @result[:success?]
    session[:user] = @result[:user]
    redirect '/volunteer'
  else
    session[:error] = @result[:error]
    redirect '/'
  end
end

post '/volunteer-sign-up' do
  @result = GPTP::VolunteerSignUp.new.run(params)
  if @result[:success?]
    session[:user] = @result[:user]
    redirect 'volunteer'

  else
    session[:error] = @result[:error]
    redirect '/'
  end
end

post '/organization-sign-in' do
  @result = GPTP::SignIn.new.run(params[:email], params[:password], false)
  if @result[:success?]
    session[:user] = @result[:user]
    redirect '/organization'
  else
    session[:org_error] = @result[:error]
    redirect '/'
  end
end

post '/organization-sign-up' do
  @result = GPTP::OrganizationSignUp.new.run(params)
  if @result[:success?]
    session[:user] = @result[:user]
    redirect '/organization'
  else
    session[:error] = @result[:error]
    redirect '/'
  end
end

post '/penny_profile' do
  @name = params[:name]
  @description = params[:description]
  @when = params[:date]
  @where = params[:location]
  @how_long = params[:time_requirement]
  @organization = params[:organization]
  @id = params[:id]
  erb :penny_profile
end

get '/penny_list' do
  t = Time.now
  today = "#{t.year} #{t.month} #{t.day}"
  penny = GPTP.db.create_penny(name: "test", description: "do good", org_id: 1, time_requirement: 4, time: 'noon', date: today, status: 0, vol_id: 1, location: "dog park")
  @array = []
  @array = GPTP.db.list_pennies
  erb :penny_list
end
