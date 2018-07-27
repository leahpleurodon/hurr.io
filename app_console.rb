require 'pry'
require_relative 'db_config'
require_relative 'models/client'
require_relative 'models/employee'
require_relative 'models/client_note'
require_relative 'models/emp_work_hour'
require_relative 'models/appointment'
require_relative 'models/appointment_note'
require_relative 'services/availability_gen'
require_relative 'services/booking_to_app'
require_relative 'services/hurr_mailer'

binding.pry