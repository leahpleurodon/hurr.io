#pry sesh with your data models loaded.
require 'pry'
require_relative 'db_config'
require_relative 'models/client'
require_relative 'models/employee'
require_relative 'models/client_note'

binding.pry