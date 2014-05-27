require 'pry'
require 'time'
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
  if session[:user] == nil || session[:user].class != GPTP::Volunteer
    erb :error
  else
    email = session[:user].email
    @pennies = GPTP::GetPennies.new.run(vol: email)
    erb :volunteer, :layout => :users
  end
end

get '/organization' do
  if session[:user] == nil || session[:user].class != GPTP::Organization
    erb :error
  else
    email = session[:user].email
    @pennies = GPTP::GetPennies.new.run(org: email)
    erb :organization, :layout => :users
  end
end

get '/all-volunteers' do
  @result = GPTP::ListEntities.new.run(type: "volunteer")
  erb :volunteer_list, :layout => :list
end

get '/all-organizations' do
  @result = GPTP::ListEntities.new.run(type: "organization")
  erb :organization_list, :layout => :list
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
    redirect '/volunteer'

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
    session[:org_error] = @result[:error]
    redirect '/'
  end
end

post '/take-penny' do
  id = params[:id]
  if session[:user].class == GPTP::Organization
    erb :error
  else
    email = session[:user].email
    GPTP::VolunteerTakesPenny.new.run(penny_id: id, volunteer_email: email)
    redirect '/volunteer'
  end
end

get '/all-pennies' do
  @result = GPTP::ListEntities.new.run(type: "pennies")
  erb :penny_list, :layout => :list
end

get '/post-penny' do
  if session[:user] == nil
    erb :error
  else
    @org_id = session[:user].id
    erb :post_penny
  end
end

<<<<<<< HEAD
get '/penny_list' do
  t = Time.now
  today = "#{t.month}/#{t.day}/#{t.year}"
  penny = GPTP.db.create_penny(name: "test", description: "do good", org_id: 1, time_requirement: 4, time: 'noon', date: today, status: 0, vol_id: 1, location: "dog park")
  @array = []
  @array = GPTP.db.list_pennies
  erb :penny_list
=======
post '/add-penny' do
  number = params[:number].to_i
  penny_hash = {name: params[:name], description: params[:description], org_id: params[:org_id].to_i, time_requirement: params[:time_req], time: params[:time], location: params[:location], date: params[:date], status: 0}
  @result = GPTP::OrganizationGivesPenny.new.run({penny: penny_hash, number: number})
  if @result[:success?]
    session[:message] = @result[:message]
    redirect '/organization'
  else
    session[:error] = @result[:message]
    redirect '/post-penny'
  end
>>>>>>> 88b6e2557647e1d9c21df1f2b7c0a5fb18b0ac5e
end



