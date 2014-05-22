require 'sqlite3'
require 'pry-debugger'

module GPTP
end

require_relative './gptp/organization.rb'
require_relative './gptp/volunteer.rb'
require_relative './gptp/penny.rb'
require_relative './gptp/db.rb'
require_relative './commands/sign_in.rb'
require_relative './commands/volunteer_takes_penny.rb'
