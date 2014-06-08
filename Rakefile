# task :default => [:test]

# namespace :app do
#   task :test do
#     ruby "spec/rake_spec.rb"
#   end
# end

# namespace :db do

#   task :load do
#     require './lib/gptp.rb'
#     puts 'load works'
#   end

#   task :create => [:load] do
#     @db ||= SQLite3::Database.new('test.db')
#     puts 'create works'
#   end

#   task :drop => [:create] do
#     File.delete("test.db")
#     puts 'drop works'
#   end

# end

require 'active_record_tasks'

ActiveRecordTasks.configure do |config|
  # These are all the default values
  config.db_dir = 'db'
  config.db_config_path = 'db/config.yml'
  config.env = 'test'
end

# Run this AFTER you've configured
ActiveRecordTasks.load_tasks
