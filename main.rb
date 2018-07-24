     
require 'sinatra'
require 'sinatra/reloader'
require 'active_record'
require_relative 'models/client' 
require_relative 'models/client_note'
require_relative 'models/employee'
require_relative 'db_config' 
enable :sessions

helpers do

  def logged_in_client
    Client.find_by(id: session[:client_id])
  end
  def client_logged_in?
    !!logged_in_client
  end
  def logged_in_employee
    Employee.find_by(id: session[:employee_id])
  end
  def employee_logged_in?
    !!logged_in_employee
  end

end


get '/' do
  erb :index
end

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