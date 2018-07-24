get '/client/me' do
    if logged_in_client
        @client = Client.find(session[:client_id])
        @client_notes = ClientNote.where(client_id: @client.id,active: true)
        erb :"clients/show_me", layout: :'layouts/public'    
    else
        redirect "/"
    end
end

put '/client/me/deactivate' do
    if logged_in_client
        client = Client.find(session[:client_id])
        client.active = false
        client.save
        session[:client_id] = nil
    end
    redirect "/"
end
get '/client/me/edit' do
    if logged_in_client
        @client = Client.find(session[:client_id])
        @titles = %w(Mrs Mr Miss Miss Master Sir Lady Lord Dr)
        erb :"/clients/edit", layout: :'layouts/public'
    elsif logged_in_employee
        redirect "/" 
    end
end