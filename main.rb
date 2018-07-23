     
require 'sinatra'
require 'active_record'
require_relative 'models/client' 
require_relative 'db_config' 
enable :sessions



get '/' do
  erb :index
end

# ------------clients-
get '/clients' do
  @clients = Client.where(active: true)
  erb :'clients/index'
end

get '/clients/new' do
  @titles = %w(Mrs Mr Miss Miss Master Sir Lady Lord Dr)
  erb :"clients/new"
end

post '/client' do
    client = Client.new(
      first_name: params["first-name"],
      last_name: params["last-name"],
      preferred_name: params["preferred-name"],
      title: params["title"],
      email: params["email"],
      dob: params["dob"],
      phone: params["phone"],
      active: true,
      last_update: Time.now,
      date_created: Time.now  
    )
    client.save
  redirect "/clients"
end

get '/clients/:id/edit' do
  @client = Client.find(params[:id])
  @titles = %w(Mrs Mr Miss Miss Master Sir Lady Lord Dr)
  erb :"clients/edit"
end

put '/client/:id' do
    client = Client.find(params[:id])
    client.first_name = params["first-name"],
    client.last_name = params["last-name"],
    client.preferred_name = params["preferred-name"],
    client.title = params["title"],
    client.email = params["email"],
    client.dob = params["dob"],
    client.phone = params["phone"],
    client.last_update = Time.now,
    planet.save
    redirect "/client/#{params[:id]}"
end
