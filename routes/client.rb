post '/clients/:id/image' do
  redirect '/' unless logged_in_employee
    tempfile = params[:file][:tempfile] 
    fileext = File.extname(params[:file][:filename])
    img_path = "/uploads/photos/client/client_#{params[:id]}#{fileext}"
    FileUtils.cp(tempfile.path, "#{FileUtils.pwd}/public/#{img_path}")
    emp = Client.where(id: params[:id])[0]
    emp.photo = img_path
    emp.save
    redirect "/clients/#{params[:id]}"
end


get '/clients' do
  redirect '/' unless logged_in_employee
    @clients = Client.where(active: true)
    erb :'clients/index', layout: :'layouts/admin'
end
  
get '/clients/:id' do
  redirect '/' unless logged_in_employee
    @client = Client.find(params[:id])
    @client_notes = ClientNote.where(client_id: @client.id,active: true)
    erb :"clients/show", layout: :'layouts/admin'
end

get '/client/new' do
  redirect '/' unless logged_in_employee
    @titles = %w(Mrs Mr Miss Miss Master Sir Lady Lord Dr)
    erb :"clients/new", layout: :'layouts/admin'
end

post '/client' do
  redirect '/' unless logged_in_employee
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
end

get '/clients/:id/edit' do
  redirect '/' unless session[:client_id].to_s == params[:id] || logged_in_employee
    @client = Client.find(params[:id])
    @titles = %w(Mrs Mr Miss Miss Master Sir Lady Lord Dr)
    if logged_in_employee
      erb :"/clients/edit", layout: :'layouts/admin'
    else  
      erb :"/clients/edit", layout: :'layouts/public'
    end
end

put '/clients/:id/deactivate' do
  redirect '/' unless logged_in_employee
    client = Client.find(params[:id])
    client.active = false
    client.save
    redirect '/clients'
end

put '/clients/:id' do
  redirect '/' unless session[:client_id].to_s == params[:id] || logged_in_employee
    client = Client.find(params[:id])
    client.first_name = params["first-name"]
    client.last_name = params["last-name"]
    client.preferred_name = params["preferred-name"]
    client.title = params["title"]
    client.email = params["email"]
    client.dob = params["dob"]
    client.phone = params["phone"]
    client.photo = params["photo"]
    client.last_update = Time.now
    client.save
  end
  
  redirect "/clients/#{params[:id]}" if logged_in_employee
  redirect '/client/me' if session[:client_id].to_s == params[:id]

  end
end

  