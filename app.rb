require 'active_record'
require 'enumerize'
require 'yaml'

# App files
require_relative 'config/config.rb'
require_relative 'interactors/check_possible.rb'
require_relative 'models/application_record.rb'
require_relative 'models/holiday.rb'

env = ENV['APP_ENV'] || 'development'
db  = YAML.load_file('db/config.yml')

ActiveRecord::Base.establish_connection(db[env])
