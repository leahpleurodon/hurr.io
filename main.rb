require 'pry'
require 'sinatra'
require 'sinatra/reloader'
require 'active_record'
require 'pony'
require_relative 'models/client' 
require_relative 'models/client_note'
require_relative 'models/employee'
require_relative 'models/emp_work_hour'
require_relative 'models/appointment_note'
require_relative 'models/appointment'
require_relative 'models/booking_request'
require_relative 'db_config' 

enable :sessions

helpers do

  require_relative'helpers'

end

get '/thanks' do
 "Thank you for your booking, someone will call shortly to confirm the booking"
end

get '/' do
  erb :index
end
#------------------------- routes----------------------------
# ------------clients-----------
require_relative 'routes/client'
# ------------client notes-----------
require_relative 'routes/client_note'
# ------------employees -----------
require_relative 'routes/employee'
# ------------client sessions -----------
require_relative 'routes/client_session'
# ------------employee sessions -----------
require_relative 'routes/employee_session'
# ------------client me -----------
require_relative 'routes/client_me'
# ------------employee me -----------
require_relative 'routes/employee_me'
# ------------work hours -----------
require_relative 'routes/emp_work_hour'
# ------------appointments -----------
require_relative 'routes/appointment'
# ------------appointment notes -----------
require_relative 'routes/appointment_note'
# ------------booking requests -----------
require_relative 'routes/booking_request'