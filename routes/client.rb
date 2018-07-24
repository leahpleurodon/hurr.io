require 'pry'
get '/clients' do
  if logged_in_employee
    @clients = Client.where(active: true)
    erb :'clients/index', layout: :'layouts/admin'
  else
    redirect '/'
  end
end
  
get '/clients/:id' do
  if logged_in_employee
    @client = Client.find(params[:id])
    @client_notes = ClientNote.where(client_id: @client.id,active: true)
    erb :"clients/show", layout: :'layouts/admin'
  else
    redirect '/'
  end
end

get '/client/new' do
  if logged_in_employee
    @titles = %w(Mrs Mr Miss Miss Master Sir Lady Lord Dr)
    erb :"clients/new", layout: :'layouts/admin'
  else
    redirect '/'
  end
end

post '/client' do
  if logged_in_employee
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
    redirect '/clients'
  else
    redirect '/'
  end
end

get '/clients/:id/edit' do
  if session[:client_id].to_s == params[:id] || logged_in_employee
    @client = Client.find(params[:id])
    @titles = %w(Mrs Mr Miss Miss Master Sir Lady Lord Dr)
    erb :"/clients/edit", layout: :'layouts/public'
  else
    redirect '/'
  end
end

put '/clients/:id/deactivate' do
  if logged_in_employee
    client = Client.find(params[:id])
    client.active = false
    client.save
    redirect '/clients'
  else
    redirect '/'
  end
end

put '/clients/:id' do
  if session[:client_id].to_s == params[:id] || logged_in_employee
    client = Client.find(params[:id])
    client.first_name = params["first-name"]
    client.last_name = params["last-name"]
    client.preferred_name = params["preferred-name"]
    client.title = params["title"]
    client.email = params["email"]
    client.dob = params["dob"]
    client.phone = params["phone"]
    client.last_update = Time.now
    client.save
  end
  if logged_in_employee
    redirect "/client/#{params[:id]}"
  elsif session[:client_id].to_s == params[:id]
    redirect '/client/me'
  else
    redirect '/'
  end
end

  