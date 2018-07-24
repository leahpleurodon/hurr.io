get '/clients' do
    @clients = Client.where(active: true)
    erb :'clients/index', layout: :'layouts/admin'
  end
  
  get '/clients/:id' do
    @client = Client.find(params[:id])
    @client_notes = ClientNote.where(client_id: @client.id,active: true)
    erb :"clients/show", layout: :'layouts/admin'
  end
  
  get '/client/new' do
    @titles = %w(Mrs Mr Miss Miss Master Sir Lady Lord Dr)
    erb :"clients/new", layout: :'layouts/admin'
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
    erb "/clients/edit"
  end
  
  put '/clients/:id/deactivate' do
      client = Client.find(params[:id])
      client.active = false
      client.save
      redirect "/clients"
  end

  put '/clients/:id' do
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
      redirect "/client/#{params[:id]}"
  end

  