# require 'pry'
require './lib/gptp.rb'
require './gptp_sinatra.rb'
require 'rspec'
require 'rack/test'
require 'capybara/rspec'
include GPTP

ENV['RACK_ENV'] = 'test'

#Mixin for testing sinatra

module RSpecMixin
  include Rack::Test::Methods
  def app
    Sinatra::Application
  end
  Capybara.app = Sinatra::Application.new
end

RSpec.configure do |config|
  config.include RSpecMixin
  config.include Capybara::DSL
  config.before(:each) do

  end
end

Capybara.configure do |config|
  config.include RSpecMixin
end
