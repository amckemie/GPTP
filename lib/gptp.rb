require 'sqlite3'
require 'pry-debugger'
require "active_record"
require 'active_record_tasks'

module GPTP
end

require_relative './gptp/organization.rb'
require_relative './gptp/volunteer.rb'
require_relative './gptp/penny.rb'
require_relative './gptp/db.rb'
require_relative 'active_record_database.rb'
require_relative './commands/sign_in.rb'
require_relative './commands/volunteer_takes_penny.rb'
require_relative './commands/sign_up.rb'
require_relative './commands/organization_sign_up.rb'
require_relative './commands/organization_gives_penny.rb'
require_relative './commands/get_pennies.rb'
require_relative './commands/list_entities.rb'
