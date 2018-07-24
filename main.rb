     
require 'sinatra'
require 'sinatra/reloader'
require 'active_record'
require_relative 'models/client' 
require_relative 'models/client_note'
require_relative 'db_config' 
enable :sessions



get '/' do
  erb :index
end

# ------------clients-----------
require_relative 'routes/client.rb'
# ------------client notess-----------
require_relative 'routes/client_note.rb'